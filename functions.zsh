#!/usr/bin/zsh

export UPSTREAM=ext-6.5.x

grefresh () {
    cd ~/sencha/github/SDK6.5
    git checkout $UPSTREAM
    git checkout $1
    git fetch -p upstream
    git pull upstream $UPSTREAM
    git push origin $UPSTREAM
    git fetch origin
}

gbranch() {
    cd ~/sencha/github/SDK6.5
    git checkout -b $1 || git checkout $1
    git pull upstream $UPSTREAM
    time sencha ant refresh
}

ks() {
    cd ~/sencha/github/SDK6.5/ext/examples/kitchensink
    sencha app build --dev material en
}

issue () {
    if (( $# == 0 ))
    then 
        p=test
    else 
        p=$1
    fi

    cd ~/sencha/projects
    if [[ -a "$p" ]]; then
        echo "***" $p "exists"
        return
    fi
    sencha -sdk ../github/SDK6.5/ext generate app test $p
    cd $p
    sed -i '' '/ext-all-rtl-debug.js/s/^/\/\//' app.json
    sed -i '' '/ext-modern-all-debug.js/s/^/\/\//' app.json
    sencha app build development
    mv ext xxx
    ln -s ../../github/SDK6.5/ext ext
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

alias 6.5='cd ~/sencha/github/SDK6.5'
alias snowdog='ssh snowdog'
alias dionysus='ssh dionysus'
alias bytor='ssh bytor'
alias xanadu='ssh xanadu'
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
alias tvim='tmux new -A -s vim'
alias lshell='tmux new -A -s lshell'
alias lvim='tmux new -A -s lvim'
alias ttmongoose='tmux -CC new -A -s mongoose'
alias ttvim='tmux -CC new -A -s vim'
alias tlist='tmux list-sessions'
alias vi='/usr/local/bin/vim'
alias df='df -P'
