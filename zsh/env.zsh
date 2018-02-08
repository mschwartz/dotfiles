#
# env variables
#

# Customize to your needs...
export LSCOLORS=exfxcxdxbxexexabagacad

export EDITOR='/usr/local/bin/vim'

cdpath=( ~ ~/sencha/github )
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
else
  export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
fi
export LESS=' -R '

