#!/usr/bin/zsh

cd() {
  builtin cd "$@" && ls
}

ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

vi3() {
  vi ~/.config/i3/config
}

alias ..='cd ..'
alias ...='cd ../..'
alias snowdog='ssh snowdog'
alias dionysus='ssh dionysus'
alias pi='ssh pi'
alias bytor='ssh bytor'
alias xanadu='ssh xanadu'
alias ha='ssh ha'
alias coldfire='ssh -Y coldfire'
alias pd='ssh -Y -L 3000:localhost:3000 pd.ddns.us'
alias presto='ssh -Y presto'
alias dreamline='ssh -Y dreamline'
alias bigmoney='ssh -Y bigmoney'
alias tmongoose='tmux new -A -s mongoose'
alias tshell='tmux -2 new -A -s shell'
#alias tvim='tmux -2 new -A -s vim'
alias tvim='! tmux -2 detach-client -s tvim; tmux -2 new -A -s tvim'
alias lshell='! tmux -2 detach-client -s lshell; tmux -2 new -A -s lshell'
alias lvim='! tmux -2 detach-client -s lvim; tmux -2 new -A -s lvim'
alias ttmongoose='tmux -CC new -A -s mongoose'
alias ttvim='tmux -CC new -A -s vim'
alias tlist='tmux list-sessions'
alias ttmux='tmux new -A -s $HOST-$$'
alias vi='/usr/local/bin/vim'
alias df='df -P'

if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
  export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
else
  export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
fi
export LESS=' -R '

sssh() {
    /usr/bin/ssh -Y -t $@ -t "tmux new -A -s $HOST-$$"
}
