#!/usr/bin/env bash

# <xbar.title>Memory Usage Graph</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.desc>Memory usage bar graph in the menu bar, modeled after mtop.5s.sh</xbar.desc>
# <xbar.dependencies>bash</xbar.dependencies>

# Memory utilization bar graph rendered onto a 25x16 BMP file created from
# scratch with no external dependencies (same technique as mtop.5s.sh).
# The dropdown shows current usage breakdown and top 5 memory-hogs.

if [ "$1" = 'activity_monitor' ]; then
    osascript <<END
    tell application "Activity Monitor"
        reopen
        activate
    end tell
END
    exit 0
fi

HISTORY_FILE=$HOME/.bitbar.mmem
[ ! -r "$HISTORY_FILE" ] && touch "$HISTORY_FILE"
[ X"$(find "$HISTORY_FILE" -mtime -2m 2>/dev/null)" != X"$HISTORY_FILE" ] && echo -n >"$HISTORY_FILE"

OLDIFS=$IFS
bmp=()
width=25
height=16

osver=$(sw_vers -productVersion 2>/dev/null || echo "13.0")

fgcol="00 00 00 ff"
bgcol="00 00 00 00"
bmp_ver=5
icontype=templateImage

if [[ $osver == 10.8.* ]]; then
    bmp_ver=1
    bgcol="d0 d0 d0 7f"
    icontype=image
fi

border=$fgcol
foreground=$fgcol
background=$bgcol
border_height=3

hexle32() {
    printf -v _num "%08x" "$1"
    echo "${_num:6:2}" "${_num:4:2}" "${_num:2:2}" "${_num:0:2}"
}

make_bmp_header() {
    headertype=$1
    headerbytes=40
    comp="00"
    if [ "$headertype" -eq 5 ]; then
        headerbytes=124
        comp="03"
    fi
    pixoffset=$((headerbytes + 14))
    pixbytes=$((width * height * 4))
    filebytes=$((pixbytes + pixoffset))

    bmp+=(
        42 4d
        $(hexle32 $filebytes)
        00 00
        00 00
        $(hexle32 $pixoffset)
        $(hexle32 $headerbytes)
        $(hexle32 $width)
        $(hexle32 $height)
        01 00
        20 00
        $comp 00 00 00
        $(hexle32 $pixbytes)
        13 0b 00 00
        13 0b 00 00
        00 00 00 00
        00 00 00 00
    )
    if [ "$headertype" -eq 5 ]; then
        bmp+=(
            00 00 ff 00
            00 ff 00 00
            ff 00 00 00
            00 00 00 ff
            42 47 52 73
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
            00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
            00 00 00 00
            00 00 00 00
            00 00 00 00
            00 00 00 00
            00 00 00 00
            00 00 00 00
            00 00 00 00
        )
    fi
}

add_row() {
    thickness=$1
    for ((i = 0; i < thickness; i++)); do
        for ((j = 0; j < width; j++)); do
            bmp+=($2)
        done
    done
}

add_pixel() {
    bmp+=($1)
}

output_bmp() {
    bmp=(${bmp[@]/#/'\x'})
    local IFS=''
    echo -ne "${bmp[*]}"
}

get_mem_stats() {
    PAGE_SIZE=$(vm_stat | grep "page size" | grep -o '[0-9]*')
    STATS=$(vm_stat)

    FREE=$(echo "$STATS" | awk '/Pages free/ {gsub(/\./,""); print $3}')
    ACTIVE=$(echo "$STATS" | awk '/Pages active/ {gsub(/\./,""); print $3}')
    INACTIVE=$(echo "$STATS" | awk '/Pages inactive/ {gsub(/\./,""); print $3}')
    WIRED=$(echo "$STATS" | awk '/Pages wired/ {gsub(/\./,""); print $4}')
    COMPRESSED=$(echo "$STATS" | awk '/Pages occupied by compressor/ {gsub(/\./,""); print $5}')

    TOTAL_BYTES=$(sysctl -n hw.memsize)

    USED_PAGES=$((ACTIVE + WIRED + COMPRESSED))
    USED_BYTES=$((USED_PAGES * PAGE_SIZE))
    FREE_BYTES=$((FREE * PAGE_SIZE))
    INACTIVE_BYTES=$((INACTIVE * PAGE_SIZE))
    ACTIVE_BYTES=$((ACTIVE * PAGE_SIZE))
    WIRED_BYTES=$((WIRED * PAGE_SIZE))
    COMPRESSED_BYTES=$((COMPRESSED * PAGE_SIZE))

    PCT=$((USED_BYTES * 100 / TOTAL_BYTES))

    TOTAL_GB=$(echo "scale=2; $TOTAL_BYTES / 1073741824" | bc)
    USED_GB=$(echo "scale=2; $USED_BYTES / 1073741824" | bc)
    FREE_GB=$(echo "scale=2; $FREE_BYTES / 1073741824" | bc)
    ACTIVE_GB=$(echo "scale=2; $ACTIVE_BYTES / 1073741824" | bc)
    WIRED_GB=$(echo "scale=2; $WIRED_BYTES / 1073741824" | bc)
    COMPRESSED_GB=$(echo "scale=2; $COMPRESSED_BYTES / 1073741824" | bc)
    INACTIVE_GB=$(echo "scale=2; $INACTIVE_BYTES / 1073741824" | bc)

    local IFS=$'\n'
    histdata=($(tail -$((width - 1)) "$HISTORY_FILE"))
    histdata+=("$PCT")
    echo "${histdata[*]}" >"$HISTORY_FILE"
}

render_graph() {
    start=$((width - ${#histdata[@]}))

    bar_heights=()
    for ((i = 0; i < ${#histdata[@]}; i++)); do
        pct=${histdata[$i]}
        bar_heights[$i]=$(( (100 - pct) * (height - border_height) / 100 ))
    done

    for ((row = 0; row < $((height - border_height)); row++)); do
        h=0
        for ((col = 0; col < width; col++)); do
            if [ $col -lt $start ]; then
                add_pixel "$background"
            elif [ ${bar_heights[$h]} -gt $row ]; then
                add_pixel "$foreground"
                h=$((h + 1))
            else
                add_pixel "$background"
                h=$((h + 1))
            fi
        done
    done
}

get_mem_stats

make_bmp_header $bmp_ver
add_row 2 "$border"
render_graph
add_row 1 "$border"

echo -n "| $icontype="
output_bmp | base64
echo "---"
echo "Memory: ${USED_GB}/${TOTAL_GB} GB (${PCT}%) | refresh=true"
echo "---"
echo "Active:      ${ACTIVE_GB} GB | font=Menlo"
echo "Wired:       ${WIRED_GB} GB | font=Menlo"
echo "Compressed:  ${COMPRESSED_GB} GB | font=Menlo"
echo "Inactive:    ${INACTIVE_GB} GB | font=Menlo"
echo "Free:        ${FREE_GB} GB | font=Menlo"
echo "---"
echo "Top Processes by Memory:"
ps -axm -o rss,comm | tail -n +2 | sort -rn | head -5 | while read rss comm; do
    mb=$(echo "scale=1; $rss / 1024" | bc)
    name=$(basename "$comm")
    printf "%7s MB  %s\n" "$mb" "$name"
done | while read line; do
    echo "$line | font=Menlo"
done
echo "---"
echo "Open Activity Monitor | bash='$0' param1=activity_monitor terminal=false"

# <bitbar.title>Memory Usage</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Your Name</bitbar.author>
# <bitbar.desc>Shows memory usage in the menu bar</bitbar.desc>
# <bitbar.dependencies>bash</bitbar.dependencies>

# Get memory stats (macOS)
PAGE_SIZE=$(vm_stat | grep "page size" | grep -o '[0-9]*')

# Parse vm_stat
STATS=$(vm_stat)
FREE=$(echo "$STATS" | awk '/Pages free/ {gsub(/\./,""); print $3}')
ACTIVE=$(echo "$STATS" | awk '/Pages active/ {gsub(/\./,""); print $3}')
INACTIVE=$(echo "$STATS" | awk '/Pages inactive/ {gsub(/\./,""); print $3}')
SPECULATIVE=$(echo "$STATS" | awk '/Pages speculative/ {gsub(/\./,""); print $3}')
WIRED=$(echo "$STATS" | awk '/Pages wired/ {gsub(/\./,""); print $4}')
COMPRESSED=$(echo "$STATS" | awk '/Pages occupied by compressor/ {gsub(/\./,""); print $5}')

# Total physical memory (bytes)
TOTAL_BYTES=$(sysctl -n hw.memsize)
TOTAL_GB=$(echo "scale=2; $TOTAL_BYTES / 1073741824" | bc)

# Used = active + wired + compressed (approximation of "used" in Activity Monitor)
USED_PAGES=$((ACTIVE + WIRED + COMPRESSED))
USED_BYTES=$((USED_PAGES * PAGE_SIZE))
USED_GB=$(echo "scale=2; $USED_BYTES / 1073741824" | bc)

# Percentage
PCT=$(echo "scale=0; $USED_BYTES * 100 / $TOTAL_BYTES" | bc)

# Menu bar display
echo "${USED_GB}/${TOTAL_GB} GB"
echo "---"
echo "Memory Used: ${PCT}%"
echo "Used: ${USED_GB} GB"
echo "Total: ${TOTAL_GB} GB"
