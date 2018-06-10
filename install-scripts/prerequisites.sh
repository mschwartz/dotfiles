#!/bin/sh

echo "installing prerequisites $platform"
if [[ $platform == 'linux' ]]; then
  PACKAGES_TO_INSTALL="\
    build-essential \
    speedtest-cli \
    source-highlight \
    zsh \
    cmake \
    vim-youcompleteme \
    python-dev \
    libboost-all-dev \
    tmux \
    curl \
    ruby-dev \
    screenfetch \
    net-tools \
    neofetch \
    urlview
    "

  sudo apt-get install -y $PACKAGES_TO_INSTALL
  echo ...nodejs
  curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
  sudo apt-get update
  sudo apt-get -y dist-upgrade
  sudo apt-get install -y nodejs
  npm config set prefix '/usr/local'
  sudo mkdir -p $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
  sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}
  sudo chown -R $(whoami) /usr/local/share/zsh/site-functions
  chsh -s $(which zsh)
elif [[ $platform == 'macos' ]]; then
  echo ...nodejs
  brew install neofetch
  brew install boost boost-python boost-python3
  # brew install nodejs etc
fi

