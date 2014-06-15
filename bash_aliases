CDPATH=~:/etc
alias presto='ssh -X -C presto'
alias server5='ssh -X -C mykes@server5.sportstwo.com'
alias server7='ssh -X -C mykes@server7.sportstwo.com'
alias jobnavs='ssh -X -C -i ~/modus/silkjs.pem ubuntu@jobnavs.moduscreate.com'
alias ec2='ssh -X -C -i ~/modus/silkjs.pem -l ubuntu'
#alias silkjs='ssh -X -C silkjs'
alias gvim='/Applications/MacVim.app/Contents/MacOS/Vim -g'
alias vim='/usr/bin/vim'
alias vi='/usr/bin/vim'
alias df='df -P'
alias ldd='otool -L'
#export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a Terminal"'
export EDITOR=/usr/bin/vim
#. ~/.nvm/nvm.sh
export PATH=/Users/mschwartz/bin:/usr/local/mysql/bin:$PATH
# ANT
export ANT_HOME='/Users/mschwartz/apache-ant-1.9.2'
export PATH=$PATH:$ANT_HOME/bin
# ANDROID SDK
export ANDROID_SDK_HOME='/Users/mschwartz/android-sdk-macosx'
export PATH=$PATH:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools

