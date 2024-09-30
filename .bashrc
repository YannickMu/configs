echo "IDE view? (y/n)"
read inp

if [[ $inp == "n" ]]
then
	PS1="\[\033[35m\]╭─\[\033[30;45m\] \w \[\033[35;40m\]  \d \[\033[30;45m\]  \t \[\033[0;35m\]\n╰─ \[\033[0m\]"
	alias cls='clear && fastfetch -l blackarch'
else
	clear
	export PS1="\033[35m\033[45m\033[30m .../\W \033[0m\033[35m \033[0m"
	alias cls='clear'
fi

# Aliases
alias ll='ls -lah'

# Autostart
cls
