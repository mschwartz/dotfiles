#!/usr/bin/zsh

#export UPSTREAM=ext-6.5.x

#grefresh () {
#    cd ~/sencha/github/SDK6.5
#    git checkout $UPSTREAM
#    git checkout $1
#    git fetch -p upstream
#    git pull upstream $UPSTREAM
#    git push origin $UPSTREAM
#    git fetch origin
#}

#gbranch() {
#    cd ~/sencha/github/SDK6.5
#    git checkout -b $1 || git checkout $1
#    git pull upstream $UPSTREAM
#    time sencha ant refresh
#}

#ks() {
#    cd ~/sencha/github/SDK6.5/ext/examples/kitchensink
#    sencha app build --dev material en
#}

#issue () {
#    if (( $# == 0 ))
#    then 
#        p=test
#    else 
#        p=$1
#    fi

#    cd ~/sencha/projects
#    if [[ -a "$p" ]]; then
#        echo "***" $p "exists"
#        return
#    fi
#    sencha -sdk ../github/SDK6.5/ext generate app test $p
#    cd $p
#    cp ~/dotfiles/sencha/app.json app.json
#    cp ~/dotfiles/sencha/app.js app.js
#    cp ~/dotfiles/sencha/Application.js app/Application.js
#    sencha app build development
#    mv ext xxx
#    ln -s ../../github/SDK6.5/ext ext
#}

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
alias 6.5='cd ~/sencha/github/SDK6.5'
alias 6.6='cd ~/sencha/github/SDK6.6'
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
alias x5='cd `pwd | sed "s/[0-9]*\.*[0-9]*$/5.x/"`'
alias x6.0='cd `pwd | sed "s/[0-9]*\.*[0-9]*$/6.0/"`'
alias x60='cd `pwd | sed "s/[0-9]*\.*[0-9]*$/6.0/"`'
alias x6.2='cd `pwd | sed "s/[0-9]*\.*[0-9]*$/6.2/"`'
alias x62='cd `pwd | sed "s/[0-9]*\.*[0-9]*$/6.2/"`'
alias tmongoose='tmux new -A -s mongoose'
alias tshell='tmux new -A -s shell'
#alias tvim='tmux new -A -s vim'
alias tvim='! tmux detach-client -s tvim; tmux -2 new -A -s tvim'
alias lshell='! tmux detach-client -s lshell; tmux -2 new -A -s lshell'
alias lvim='! tmux detach-client -s lvim; tmux -2 new -A -s lvim'
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
