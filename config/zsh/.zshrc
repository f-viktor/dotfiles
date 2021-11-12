# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/.history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd nomatch INC_APPEND_HISTORY
unsetopt beep
bindkey -v
export KEYTIMEOUT=1
bindkey -v '^R' history-incremental-search-backward

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dna/.config/zsh/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall



# Enable colors and change prompt:
autoload -U colors && colors

PS1='%#%1d '

# http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors
export LS_COLORS="di=01;33:ow=01;91"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# defaults, tho they don't work
export EDITOR=nvim
export BROWSER=brave

# rebind buttons because zsh doesnt read /etc/inputrc
# just start cat, and press the button you want
# urxvt
#bindkey "^[Oa" beginning-of-line
#bindkey "^[Ob" end-of-line
#bindkey "^[[3~" delete-char
#bindkey "^[Oc" forward-word
#bindkey "^[Od" backward-word

# rustyboi
bindkey "^[[1;5A" beginning-of-line
bindkey "^[[1;5B" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[2~" delete-char
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# aliases
alias ls='ls --color=auto'
alias SS='sudo systemctl'
alias sp='sudo pacman'
alias pacs='pacman -Ss'
alias sv='sudo nvim'
alias v='nvim'
alias fclip='xclip -sel clip <'
alias finda='find / -iname $1 2>/dev/null'
alias pc='python -c'
alias pls='sudo $(fc -ln -1)'
alias sxiv="sxiv -a"
alias signal="signal-desktop --use-tray-icon & disown"

soket () {
if [ $(cat  /proc/sys/kernel/yama/ptrace_scope) != 0 ]; then
   echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
   fi
   echo "ready to fork $PWD/$1 on port 3333\n"
   socat TCP-LISTEN:3333,reuseaddr,fork EXEC:$1
}
alias sc='soket'
#alias sc='printf "socat TCP-LISTEN:31337,reuseaddr,fork EXEC:%s\n" $1'

alias r='lfcd'



# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

