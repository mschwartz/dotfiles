
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
echo bash_profile

source $HOME/dotfiles/path

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s ~/.bashrc ]] && source ~/.bashrc

#export PATH=/Users/mschwartz/bin/Sencha/Cmd/4.0.2.67:$PATH

#export SENCHA_CMD_3_0_0="/Users/mschwartz/bin/Sencha/Cmd/5.1.3.61"

#export PATH=/Users/mschwartz/bin/Sencha/Cmd/4.0.3.74:$PATH

export PATH=/Users/mschwartz/bin/Sencha/Cmd/5.0.0.160:$PATH

#export PATH=/Users/mschwartz/bin/Sencha/Cmd/3.1.2.342:$PATH

#export PATH=/Users/mschwartz/bin/Sencha/Cmd/4.0.5.87:$PATH

###-tns-completion-start-###
if [ -f /Users/mschwartz/.tnsrc ]; then 
    source /Users/mschwartz/.tnsrc 
fi
###-tns-completion-end-###

#export PATH=/Users/mschwartz/bin/Sencha/Cmd/5.1.3.61:$PATH

export PATH="/Users/mschwartz/bin/Sencha/Cmd/6.0.2.14/..:$PATH"

export PATH="/Users/mschwartz/bin/Sencha/Cmd/6.1.0.65/..:$PATH"
export PATH="/Users/mschwartz/bin/Sencha/Cmd/6.0.2.14/..:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="$HOME/.cargo/bin:$PATH"

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
