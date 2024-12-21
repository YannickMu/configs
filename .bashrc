export LANG="en_SG.UTF-8"
export LC_TIME="de_CH.UTF-8"
export LC_TELEPHONE="de_CH.UTF-8"
export LC_MEASUREMENT="de_CH.UTF-8"

PS1="\[\033[38;5;197m\]╭─\[\033[30;48;5;197m\] \w \[\033[38;5;197;40m\]  \d \[\033[30;48;5;197m\]  \t \[\033[0;38;5;197m\]\n╰─ \[\033[0m\]"
alias cls='clear && fastfetch -l blackarch'
echo "IDE view? (y/n)"
read inp

if [[ $inp == "n" ]]
then
	PS1="\[\033[38;5;197m\]╭─\[\033[30;48;5;197m\] \w \[\033[38;5;197;40m\]  \d \[\033[30;48;5;197m\]  \t \[\033[0;38;5;197m\]\n╰─ \[\033[0m\]"
	alias cls='clear && fastfetch -l blackarch'
else
	clear
	export PS1="\033[38;5;197m\033[48;5;197;30m  .../\W \033[0m\033[38;5;197m \033[0m"
	alias cls='clear'
fi

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lah'

# Autostart
cls

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
