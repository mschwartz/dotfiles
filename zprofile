source ~/dotfiles/path

if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

if [ -f "$HOME/.zprofile.local" ]; then
    . "$HOME/.zprofile.local"
fi

