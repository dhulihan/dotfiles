autoload colors && colors

ANIMALS=(🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵🐙🦄🐝);
FOOD=(🍌🍇🍍🍉🍎🍒🍓🥝🥑🥥🌶🥕🍄🍋🍐🥨🥐🍤🍬🍭🍰🍖🍔🌭🍕🌮🌯🍟🍿🍦🍪🍨🍩🍆);
CREEPY=(💀🌙🌜🌚🕷️🌕👾🔪👺☠️🐜🗡🕯👻🎃⚡👹🤡🔦);
MONTH_01=(🏂☕);
MONTH_02=(🏂🍫💝);
MONTH_03=(🍀🏀);
MONTH_04=(🌺🌹🌸🌩️);
MONTH_05=(🌼🥎🥏);
MONTH_06=(🍔🌻⚽🚴⚾);
MONTH_07=(🏊🛹🎇🏄);
MONTH_08=(🏫📏🏄);
MONTH_09=(🍂🍁🏈);
MONTH_10=(💀🌙🌜🌚🕷️🌕👾👺☠️🐜👻🎃⚡👹🤡🔦);
MONTH_11=(🦃🏈🌽🍗🥧🍽🍞🥖🍎🥂);
MONTH_12=(🎁🎄🎅🤶🍪🥛🔔🧦);

# autorotating prompt emojis based on month
#PROMPT_EMOJIS_VAR="MONTH_$(date +%m)"
#eval "PROMPT_EMOJIS=\"\${$PROMPT_EMOJIS_VAR}\""

# hard coded prompt emoji set
export PROMPT_EMOJIS=$FOOD

if (( $+commands[git] ))
then
  git="$commands[git]"
else
  git="/usr/bin/git"
fi

git_branch() {
  echo $($git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_commit() {
  echo "%{$fg_bold[blue]%}$($git rev-parse --short HEAD 2>/dev/null)%{$reset_color%}"
}

git_commit_timestamp() {
	echo "%{$fg_bold[grey]%}$(git log -1 --format="%ar")%{$reset_color%}"
}

git_dirty() {
  if $(! $git status -s &> /dev/null)
  then
    echo ""
  else
    if [[ $($git status --porcelain) == "" ]]
    then
      echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info() {
 ref=$($git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed() {
  $git cherry -v @{upstream} 2>/dev/null
}

need_push() {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  fi
}

rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "%{$fg_bold[yellow]%}$(ruby_version)%{$reset_color%} "
  else
    echo ""
  fi
}

directory_name() {
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

# Date Stamp
datestamp() {
  echo "%{$fg_bold[grey]%}%D{%Y-%m-%d} %D{%H:%M:%S.%. %Z}%{$reset_color%}"
}

random_emoji() {
  echo $SELECTED_EMOJI
}


set_prompt() {
	export PROMPT=$'\n$(random_emoji) $(datestamp) %(?.%F{green}.%F{red}%?)%f\n$(directory_name) $(git_dirty) $(git_commit) $(git_commit_timestamp)$(need_push)\n%F{242}$ %f'
}

precmd() {
  export SELECTED_EMOJI=${PROMPT_EMOJIS[$RANDOM % ${#PROMPT_EMOJIS[@]}]};
  # set title
  #title "zsh" "%m" "%55<...<%~"
  set_prompt
}
