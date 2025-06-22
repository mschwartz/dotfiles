#
# functions - these act like aliases but can have logic flow
#

# GIT
function is_in_local() {

    if [[ -z ${existed_in_local} ]]; then
        echo 0
    else
        echo 1
    fi
  }
master() {
    local branch_exists=$(git branch --list master)

  if [[ -z ${branch_exists} ]]; then
    echo 'found master'
    git checkout master
    upstream=`git remote | grep upstream`
    if [[ "$upstream" == "" ]]; then
      git pull origin master
    else
      git pull upstream master
      git push origin master
    fi
  else
    local branch_exists=$(git branch --list main)
    if [[ -z ${branch_exists} ]]; then
      echo 'found main'
      git checkout main
      upstream=`git remote | grep upstream`
      if [[ "$upstream" == "" ]]; then
        git pull origin main
      else
        git pull upstream main
        git push origin main
      fi
    fi
  fi
}

main() {
    git checkout main
    upstream=`git remote | grep upstream`
    if [[ "$upstream" == "" ]]; then
	git pull origin main
    else
	git pull upstream main
	git push origin main
    fi
}

develop() {
    git checkout develop
    git pull origin develop
}

# cd <dir> automatically does an ls after changing
cd() {
    builtin cd "$@" && eza
}

close() {
  osascript -e "quit app \"$@\""
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
    TERM=$TERM tmux -2 detach-client -s $1
    TERM=$TERM tmux -2 new -A -s $1
}

sh() {
  touch $@ 
  chmod 755 $@
  ls -l $@
}

e() {
    # if [ "$TMUX" != "" ]; then
    # 	tmux set-option history-limit 100
    # 	tmux split-window -h 
    # 	tmux set-option history-limit 5000
    # 	# tmux rename-window $TMUX_PANE emacs
    # 	echo $TMUX_PANE
    # 	printf '\033]2;%s\033\\' 'emacs'
    # fi

    if [ "$1" = "" ]; then
	emacs --debug-init -nw 
    else
	emacs --debug-init -nw --no-desktop $@
    fi
}

1password() {
    eval $(op signin my)
}

cls() {
  reset;
  clear;
  stty sane;
  if [ "$TMUX" != "" ]; then
    tmux clear-history;
  fi
}

find() {
    /usr/bin/find $@ -not -path "./node_modules/*"
}

sclack() {
    cd ~/github/other/sclack && cls && ./app.py
}

update-keys() {
  echo ">>> Update Keys"
  sudo pacman --noconfirm -S archlinux-keyring
  sudo pacman-key --refresh-keys
}

update() {
  if [[ "$OS" == "Darwin" ]]; then
    echo "doing brew update"
    brew update
    echo "doing brew upgrade"
    brew upgrade
  else
    echo ">>> Update MirrorList"
    sudo reflector --verbose --country 'US' -l 5 --sort rate --save /etc/pacman.d/mirrorlist
    #    yay -R --noconfirm yay
    echo ">>> PACMAN UPDATE"
    sudo pacman --noconfirm -Syyu
    #    cd ~/github/arch/yay
    #    ggpull
    #    makepkg -si --noconfirm
    echo ">>> AUR UPDATE"
    yay --noconfirm -Syyu
  fi
}

get() {
    echo yay --noconfirm -Syy $@
    yay --noconfirm -Syy $@
}

remove() {
    echo yay --noconfirm -Rs $@
    yay --noconfirm -Rs $@
}

view() {
    case $TERMINFO in
	*kitty*)
	;;
	*)
	    /usr/bin/view $1
	    return
	    ;;
    esac

    local testfn=`echo $1 | tr '[:lower:'] '[:upper:']`
    case $testfn in
	*.JPG|*.JPEG|*.PNG|*.GIF|*.TIF|*.EPS|*.AI|*.BMP)
	    echo ""
	    kitty +kitten icat --align left $1
	    identify $1
	    echo ""
	    ;;
	*)
	    /usr/bin/view $1
    esac
}

function encrypt {
  echo "encrypting (recursively)" $@
  ccencrypt -r $@
}
function decrypt  {
  echo "decrypting (recursively)" $@
  ccdecrypt -r $@
}
