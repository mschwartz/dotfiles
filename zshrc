# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="agnoster"
#ZSH_THEME="clean"
DEFAULT_USER=mschwartz

#TERMINAL=urxvt
unalias run-help 2>/dev/null
autoload run-help
HELPDIR=/usr/local/share/zsh/help
# portable way to get # of processors/cores:
export JOBS=`getconf _NPROCESSORS_ONLN`

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
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(zsh-autosuggestions z vi-mode git sudo colorize bower brew colored-man-pages node npm jsontools osx redis-cli rvm sublime themes tmux docker docker-compose zsh-syntax-highlighting vscode systemd fzf fasd command-not-found)
#plugins=(zsh-autosuggestions z vi-mode git sudo colorize brew colored-man-pages node npm jsontools osx redis-cli rvm sublime themes tmux docker docker-compose zsh-syntax-highlighting  vscode systemd fzf fasd command-not-found)
source $ZSH/oh-my-zsh.sh


#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 
#source $(rvm 1.9.3 do rvm env --path)


setopt no_share_history
fpath=(~/dotfiles/completions/zsh/hub $fpath)

source ~/dotfiles/zsh/env.zsh
source ~/dotfiles/zsh/functions.zsh
source ~/dotfiles/zsh/aliases.zsh

###-tns-completion-start-###
if [ -f /Users/mschwartz/.tnsrc ]; then 
    source /Users/mschwartz/.tnsrc 
fi
###-tns-completion-end-###

#source ~/.iterm2_shell_integration.`basename $SHELL`
#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
#
#
#if [ -f $HOME/.zshrc.local ]; then
#    source $HOME/.zshrc.local
#fi

DISPLAY_SAVE=DISPLAY
unset DISPLAY
neofetch
DISPLAY=$DISPLAY_SAVE


# disable ctrl-s (xon/xoff)
stty -ixon

#if [ -f /usr/share/nvm/init-nvm.sh ]; then
#  source /usr/share/nvm/init-nvm.sh
#fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

PATH="/home/mschwartz/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/mschwartz/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/mschwartz/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/mschwartz/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/mschwartz/perl5"; export PERL_MM_OPT;

#if [ -f $HOME/github/other/emsdk/emsdk_env.sh ]; then
#  source $HOME/github/other/emsdk/emsdk_env.sh
#fi
#PATH=~/go/bin:$PATH; export PATH




if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi

#[ ! -z "$KITTY_WINDOW_ID" ] && export TERM=xterm-kitty

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Must be sourced at end of .zshrc
if [ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /usr/share/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting.zsh
fi

#source $HOME/.cargo/env

