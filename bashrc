# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc


# Powerline

if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi

# Colorls
alias ll='colorls -lA --sd --gs --group-directories-first'
alias ls='colorls --group-directories-first'

source $(dirname $(gem which colorls))/tab_complete.sh



# Custom user alias
alias ram='sudo ~/WorkBench/BASH/clear_buffer.sh'
alias mv='mv -v'
alias cp='cp -v'
alias rm='rm -rvfi'
alias jn='jupyter-notebook'
alias check='sudo dnf update -y && sudo dnf upgrade -y'
alias cls='clear'
alias sleep='systemctl suspend'
alias vi='vim'
