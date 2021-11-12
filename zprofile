
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
source ~/dotfiles/path

if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

if [ -f "$HOME/.zprofile.local" ]; then
    . "$HOME/.zprofile.local"
fi


export PATH="$HOME/.cargo/bin:$PATH"

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
