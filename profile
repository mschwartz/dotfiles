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

#export PATH=/Users/mschwartz/bin/Sencha/Cmd/4.0.2.67:$PATH

#export PATH=/Users/mschwartz/bin/Sencha/Cmd/4.0.5.87:$PATH

#export SENCHA_CMD_3_0_0="/Users/mschwartz/bin/Sencha/Cmd/5.1.3.61"

#export PATH=/Users/mschwartz/bin/Sencha/Cmd/5.1.3.61:$PATH

export PATH="/Users/mschwartz/bin/Sencha/Cmd/6.0.2.14/..:$PATH"
#export PATH="/Users/mschwartz/bin/Sencha/Cmd/SenchaCmd-6.1.0.54-osx/:$PATH"
