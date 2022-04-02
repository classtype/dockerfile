function color_my_prompt {
  local RED="\[\e[0;31m\]"         # Красный
  local BLUE="\[\e[1;34m\]"        # Синий (тёмный)
  local GREEN="\[\e[0;32m\]"       # Зеленый (тёмный)
  local YELLOW="\[\e[1;33m\]"      # Желтый
  local VIOLET="\[\e[1;35m\]"      # Фиолетовый
  local BLUE_LIGHT="\[\e[0;36m\]"  # Синий (светлый)
  local GREEN_LIGHT="\[\e[1;32m\]" # Зеленый (светлый)
  local BRANCH=$BLUE_LIGHT         # Цвет ветки (по умолчанию светло синий)
  local CLEAR="\[\e[0m\]"          # Сброс цвета
  
  if   [[ $(__git_ps1) =~ "*" ]]; then BRANCH=$RED    # Modified
  elif [[ $(__git_ps1) =~ "$" ]]; then BRANCH=$YELLOW # Add stash
  elif [[ $(__git_ps1) =~ "%" ]]; then BRANCH=$VIOLET # Untracked files
  elif [[ $(__git_ps1) =~ "+" ]]; then BRANCH=$GREEN  # Add stage
  fi
  
  PS1="$GREEN_LIGHT\u$CLEAR:$BLUE\w$BRANCH$(__git_ps1 " (%s) ")$CLEAR$ "
}

export PROMPT_COMMAND=color_my_prompt

if [ -f /root/.git-prompt.sh ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_HIDE_IF_PWD_IGNORED=true
  GIT_PS1_SHOWCOLORHINTS=true
  . /root/.git-prompt.sh
fi

alias c='clear'
alias l='c && ls -alF'
alias s='c && git status'
alias c9='/root/.c9/start'
