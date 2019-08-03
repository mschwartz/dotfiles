#
# zsh aliases
#

# handy
alias ..='cd ..'
alias ...='cd ../..'
alias so='source'

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
alias robospeak='ssh robospeak'
alias yyz='ssh yyz'

# tmux
alias tlist='tmux list-sessions'
### see also tmuxx function in functions.sh

# vim
if [ -f /usr/local/bin/vim ]; then
  alias vi='/usr/local/bin/vim'
  alias vim='/usr/local/bin/vim'
elif [ -f /usr/bin/vim ]; then
  alias vi='/usr/bin/vim'
  alias vim='/usr/bin/vim'
fi

# nvim
if [ -f /usr/local/bin/nvim ]; then
  alias vi='/usr/local/bin/nvim'
elif [ -f /usr/bin/nvim ]; then
  alias vi='/usr/bin/nvim'
fi

# programs
alias browse=w3m
alias mutt=neomutt
alias node='/usr/bin/node'
alias grep='grep --exclude-dir={.bzr,CVS,.git,.hg,.svn,node_modules}'
alias df='df -P'
# force me to forget muscle memory npm
alias npm='echo "Use yarn"'

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

