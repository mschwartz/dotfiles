#
# functions - these act like aliases but can have logic flow
#

# cd <dir> automatically does an ls after changing
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

# sssh host - automatically creates a new tmux session on remote host
sssh() {
    /usr/bin/ssh -Y -t $@ -t "tmux new -A -s $HOST-$$"
}

# calculate result of expression on command line: = expression
# = 10 + 10 prints 20
function = {
    calc="${@//x/*}"
    bc -l <<<"scale=10;$calc"
}

# alias tmuxx='echo $1; ! tmux -2 detach-client -s $1; tmux -2 new -A -s $1'
tmuxx() {
  echo "$1"
  tmux -2 detach-client -s $1
  tmux -2 new -A -s $1
}

1password() {
  eval $(op signin my)
}
