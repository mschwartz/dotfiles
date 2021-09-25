#
# env variables
#

# OS
export OS=`uname -s`

# Customize to your needs...
export LSCOLORS=exfxcxdxbxexexabagacad

cdpath=( ~ ~/github ~/github/ModusCreateOrg ~/github/ModusLabs )

if [ -d /Users/mschwartz/android-sdk-macosx ]; then
  export ANDROID_HOME='/Users/mschwartz/android-sdk-macosx'
fi

### LESS/LESSPIPE
if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
  export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
elif [ -f /usr/bin/src-hilite-lesspipe.sh ]; then
  export LESSOPEN="|/usr/bin/src-hilite-lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
elif [ -f /opt/homebrew/bin/lesspipe.sh ]; then
  export LESSOPEN="| /opt/homebrew/bin/lesspipe.sh %s"
else
  export LESSOPEN="|/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
fi
export LESS=' -R '

export EDITOR=`which vi`

