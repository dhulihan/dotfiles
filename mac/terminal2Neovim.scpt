on run {input, parameters}
set nvimCommand to "nvim "
set filepaths to ""

if input is not {} then
    repeat with currentFile in input
	set filepaths to filepaths & quoted form of POSIX path of currentFile & " "
    end repeat
end if

tell application "Terminal"
    activate
    if (count of windows) is 0 then
	do script nvimCommand & filepaths
    else
	do script nvimCommand & filepaths in front window
    end if
end tell
end run
