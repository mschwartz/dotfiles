#
# zsh aliases
#

# handy
alias ..='cd ..'
alias ...='cd ../..'
# ssh hosts
alias snowdog='ssh snowdog'
alias dionysus='ssh dionysus'
alias pi='ssh pi'
alias bytor='ssh bytor'
alias xanadu='ssh xanadu'
alias cygnus='ssh cygnus'
alias ha='ssh ha'
alias coldfire='ssh -Y coldfire'
alias pd='ssh -Y -L 3000:localhost:3000 pd.ddns.us'
alias presto='ssh -Y presto'
alias dreamline='ssh -Y dreamline'
alias bigmoney='ssh -Y bigmoney'
# tmux
alias tmongoose='tmux new -A -s mongoose'
alias tshell='tmux -2 new -A -s shell'
#alias tvim='tmux -2 new -A -s vim'
alias tvim='! tmux -2 detach-client -s tvim; tmux -2 new -A -s tvim'
alias lshell='! tmux -2 detach-client -s lshell; tmux -2 new -A -s lshell'
alias lvim='! tmux -2 detach-client -s lvim; tmux -2 new -A -s lvim'
alias ttmongoose='tmux -CC new -A -s mongoose'
alias ttvim='tmux -CC new -A -s vim'
alias tlist='tmux list-sessions'
alias ttmux='tmux new -A -s $HOST-$$'
# vim
alias i3c='vi ~/.config/i3/config'
alias vi3='vi ~/.config/i3/config'
if [ -f /usr/local/bin/vim ]; then
  alias vi='/usr/local/bin/vim'
fi
alias df='df -P'

