#!/usr/bin/zsh

grefresh () {
    git checkout $1
    git fetch -p upstream
    git pull upstream $1
    git push origin $1
    git fetch origin
}

gbranch() {
    git checkout -b $1 || git checkout $1
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

