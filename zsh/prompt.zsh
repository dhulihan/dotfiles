autoload colors && colors

ANIMALS=(🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵🐙🦄🐝);
FOOD=(🍌🍇🍍🍉🍎🍒🍓🥝🥑🥥🌶🥕🍄🍋🍐🥨🥐🍤🍬🍭🍰🍖🍔🌭🍕🌮🌯🍟🍿🍦🍪🍨🍩);
CREEPY=(💀🌙🌜🌚🕷️🌕👾👺☠️🐜👻🎃⚡👹🤡🔦);
HOLIDAYS=(🎃);
PROMPT_EMOJIS=$CREEPY;

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
  echo "%{$fg_bold[grey]%}$($git rev-parse --short HEAD 2>/dev/null)%{$reset_color%}"
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
  echo "%{$fg_bold[grey]%}%D{%Y-%m-%f} %D{%H:%M:%S.%. %Z}%{$reset_color%}"
}

random_emoji() {
  echo $SELECTED_EMOJI
}


set_prompt() {
  export PROMPT=$'\n$(datestamp)\n$(rb_prompt)in $(directory_name) $(git_dirty) $(git_commit)$(need_push)\n$(random_emoji) '
}

precmd() {
  export SELECTED_EMOJI=${PROMPT_EMOJIS[$RANDOM % ${#PROMPT_EMOJIS[@]}]};
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
