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


# History Settings
export HISTCONTROL=erasedups:ignoreboth
shopt -s histappend

# Ignore bunch of commands listed inside a file

ignore_hist="$HOME/.bash_ignore"

if [ -f "$ignore_hist" ]; then

	# Use grep command to extract & format the commands from the file
	ignore_commands=$(grep -vE '^\s*#' "$ignore_hist" | tr '\n' ':')

	#Set Ignore History with the extracted commands
	export HISTIGNORE="${ignore_commands%:}"
fi

############################################# Custom User Alias ###############################################
alias ram='sudo ~/bin/clear_buffer'
alias mv='mv -v'
alias cp='cp -vr'
alias cls='clear'
alias sus='systemctl suspend'
alias vi='vim'
alias ip='ip -c'
alias ll='ls -lhtr --color=auto'
alias fw='firewall-cmd'
