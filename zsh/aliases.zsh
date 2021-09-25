#
# zsh aliases
#

# handy
alias ..='cd ..'
alias ...='cd ../..'
alias so='source'
alias sane='stty sane'
alias here='export HERE=.'
alias there='cd $HERE'

# ssh hosts
alias snowdog='ssh snowdog'
alias dionysus='ssh dionysus'
alias pi='ssh pi'
alias ubnt='ssh 192.168.1.1'
alias bytor='ssh bytor'
alias xanadu='ssh xanadu'
alias cygnus='ssh cygnus'
alias ha='ssh robodomo'
alias coldfire='ssh -Y coldfire'
alias pd='ssh -Y -L 3000:localhost:3000 pd.ddns.us'
alias presto='ssh -Y presto'
alias dreamline='ssh -Y dreamline'
alias bigmoney='ssh -Y bigmoney'
alias nuc1='ssh nuc1'
alias apollo='ssh apollo'
alias robospeak='ssh robospeak'
alias yyz='ssh yyz'
alias pi4='ssh pi4'
alias pi48='ssh pi48'
alias nas1='ssh nas1'
alias warpaint='ssh warpaint'

# tmux
alias tlist='tmux list-sessions'
### see also tmuxx function in functions.sh

#alias emacs="emacsclient -a '' -c"
# alias e='emacs -nw'
alias make="make -j 20"

if [ -f /usr/bin/bpytop ]; then
  alias top='bpytop'
fi

# vim/nvim
if [ -f /opt/homebrew/bin/nvim ]; then
  alias vi='/opt/homebrew/bin/nvim'
  alias vim='/opt/homebrew/bin/nvim'
elif [ -f /usr/local/bin/nvim ]; then
  alias vi='/usr/local/bin/nvim'
  alias vim='/usr/local/bin/nvim'
elif [ -f /usr/bin/nvim ]; then
  alias vi='/usr/bin/nvim'
  alias vim='/usr/bin/nvim'
elif [ -f /usr/local/bin/vim ]; then
  alias vi='/usr/local/bin/vim'
  alias vim='/usr/local/bin/vim'
elif [ -f /usr/bin/vim ]; then
  alias vi='/usr/bin/vim'
  alias vim='/usr/bin/vim'
fi

# programs
alias browse=w3m
alias mutt=neomutt
if [ -f /usr/bin/node] ]; then
  alias node='/usr/bin/node'
fi

alias grep='grep --exclude-dir={.bzr,CVS,.git,.hg,.svn,.ccls,.ccls-cache,node_modules} --exclude=\*.{o,a,bin,elf,img,sym}'
alias df='df -P'
# force me to forget muscle memory npm
# alias npm='echo "Use yarn"'

# edit configuration files
alias i3config='vi ~/.config/i3/config'
alias vimrc='vi ~/.vimrc'
alias aliases.zsh='vi ~/dotfiles/zsh/aliases.zsh'
alias zshrc='vi ~/.zshrc'
alias env.zsh='vi ~/dotfiles/zsh/env.zsh'
alias functions.zsh='vi ~/dotfiles/zsh/functions.zsh'
alias muttrc='vi ~/.config/mutt/muttrc'
# vim like edit configuration files
alias e3='vi ~/.config/i3/config'
alias ea='vi ~/dotfiles/zsh/aliases.zsh'
alias eb='vi ~/dotfiles/config/i3/i3blocks.conf'
alias ee='vi ~/dotfiles/zsh/env.zsh'
alias ef='vi ~/dotfiles/zsh/functions.zsh'
alias ep='vi ~/dotfiles/config/polybar/config'
alias er='vi ~/dotfiles/config/ranger/rc.conf'
alias ev='vi ~/.vimrc'
alias et='vi ~/dotfiles/tmux.conf'
alias ez='vi ~/.zshrc.local ~/.zshrc'

alias root='cd `git rev-parse --show-toplevel`'
alias modus='cd $HOME/github/ModusCreateOrg'
