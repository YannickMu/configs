PS1="\[\033[38:5:197m\]╭─\[\033[30;48:5:197m\] \w \[\033[38:5:197;40m\]  \d \[\033[30;48:5:197m\]  \t \[\033[0;38:5:197m\]\n╰─ \[\033[0m\]"
alias cls='clear && fastfetch -l blackarch'
echo "IDE view? (y/n)"
read inp

if [[ $inp == "n" ]]
then
	PS1="\[\033[38:5:197m\]╭─\[\033[30;48:5:197m\] \w \[\033[38:5:197;40m\]  \d \[\033[30;48:5:197m\]  \t \[\033[0;38:5:197m\]\n╰─ \[\033[0m\]"
	alias cls='clear && fastfetch -l blackarch'
else
	clear
	export PS1="\033[38:5:197m\033[48:5:197;30m .../\W \033[0m\033[38:5:197m \033[0m"
	alias cls='clear'
fi

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lah'

# Autostart
cls
