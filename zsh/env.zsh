#
# env variables
#

# OS
export OS=`uname -s`

# Customize to your needs...
export LSCOLORS=exfxcxdxbxexexabagacad

cdpath=( ~ ~/github ~/github/ModusCreateOrg )
#export PATH="/Users/mschwartz/bin/Sencha/Cmd/6.1.2.15/..:$PATH"
#export PATH="/Users/mschwartz/bin/Sencha/Cmd/6.2.0.3/..:$PATH"
#export PATH="/Users/mschwartz/bin/Sencha/Cmd/6.2.0.23/..:$PATH"
#export PATH="/Users/mschwartz/bin/Sencha/Cmd/6.2.0.46/..:$PATH"
#export PATH="/Users/mschwartz/bin/Sencha/Cmd/6.2.0.103/..:$PATH"
#export PATH="/Users/mschwartz/bin/Sencha/Cmd/6.5.0.42/..:$PATH"
#export PATH="/home/mschwartz/bin/Sencha/Cmd:$PATH"
#export GMAIL_CREDENTIALS="$HOME/Dropbox/credentials/gmail"
#source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ -d /Users/mschwartz/android-sdk-macosx ]; then
  export ANDROID_HOME='/Users/mschwartz/android-sdk-macosx'
fi

if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
  export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
elif [ -f /usr/bin/src-hilite-lesspipe.sh ]; then
  export LESSOPEN="|/usr/bin/src-hilite-lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
if [ -f /opt/homebrew/bin/lesspipe.sh ]; then
  export LESSOPEN="| /opt/homebrew/bin/lesspipe.sh %s"
else
  export LESSOPEN="|/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
fi
export LESS=' -R '

#if [ "$OS" = 'Darwin' ]; then
#  export EDITOR='/usr/local/bin/vim'
#  if [ "$TERM" = "st-256color" ]; then
#    export TERM="xterm-256color"
#  fi
#  if [ "$KONSOLE_PROFILE_NAME" != "" ]; then
#    export TERM=konsole-256-color
#  fi
#else
  export EDITOR='/usr/bin/vim'
#  export TERM="xterm-256color"
#fi

