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
alias i3config='vi ~/.config/i3/config'
alias aliases.zsh='vi ~/dotfiles/zsh/aliases.zsh'
alias zshrc='vi ~/.zshrc'
alias env.zsh='vi ~/dotfiles/zsh/env.zsh'
alias functions.zsh='vi ~/dotfiles/zsh/functions.zsh'
alias node='/usr/bin/node'

if [ -f /usr/local/bin/vim ]; then
  alias vi='/usr/local/bin/vim'
fi
alias df='df -P'
alias slack slack-term

