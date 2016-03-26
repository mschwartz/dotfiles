# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
#ZSH_THEME="clean"
DEFAULT_USER=mschwartz

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git colorize bower brew coffee colored-man node npm osx redis-cli rvm screen sublime terminalapp themes)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export LSCOLORS=exfxcxdxbxexexabagacad

export EDITOR='/usr/local/bin/vim'

cdpath=( ~ )
alias snowdog='ssh snowdog'
alias bytor='ssh bytor'
alias xanadu='ssh xanadu'
alias presto='ssh -X presto'
alias dreamline='ssh -X dreamline'

alias vi='/usr/local/bin/vim'
alias df='df -P'

if [ -f $HOME/.zshrc.local ]; then
    source $HOME/.zshrc.local
fi

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
#source $(rvm 1.9.3 do rvm env --path)

export ANDROID_HOME='/Users/mschwartz/android-sdk-macosx'

setopt no_share_history
fpath=(~/dotfiles/completions/zsh/hub $fpath)


###-tns-completion-start-###
if [ -f /Users/mschwartz/.tnsrc ]; then 
    source /Users/mschwartz/.tnsrc 
fi
###-tns-completion-end-###

source ~/.iterm2_shell_integration.`basename $SHELL`
#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
#
#
function = {
    calc="${@//x/*}"
    bc -l <<<"scale=10;$calc"
}
