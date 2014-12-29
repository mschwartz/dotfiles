# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	echo bash
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi


export PATH=/Users/mschwartz/bin/Sencha/Cmd/5.0.0.160:$PATH
export HOMEBREW_GITHUB_API_TOKEN='fa3d7db0773c67b54443dd738bb83af2f47aa9aa'
export SENCHA_CMD_3_0_0="/Users/mschwartz/bin/Sencha/Cmd/5.0.0.160"
