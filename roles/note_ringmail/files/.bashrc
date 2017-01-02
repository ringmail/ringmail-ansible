# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias vi="vim"

export PS1='\[\033[00;32m\]\u\[\033[01m\]@\[\033[00;34m\]\h\[\033[01m\]:\[\033[00;35m\]\w\[\033[00m\]\[\033[01;30m\](`git branch 2>/dev/null|grep -e ^* |tr -d \*\ `)\[\033[00m\]\$ '

