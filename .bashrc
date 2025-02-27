umask 0027

export LANG="en_GB.UTF-8"
export LC_TIME="de_CH.UTF-8"
export LC_TELEPHONE="de_CH.UTF-8"
export LC_MEASUREMENT="de_CH.UTF-8"

alias cls='clear && fastfetch --raw ~/Bilder/FastFetch/image.bin --color green'
echo "IDE view? (y/n)"
read inp

if [[ $inp == "n" ]]
then
	PS1="\[\033[38;5;197m\]╭─\[\033[30;48;5;197m\] \w \[\033[38;5;197;40m\]  \d \[\033[30;48;5;197m\]  \t \[\033[38;5;197;40m\] ?? $? \[\033[0;30;5;197m\]\n\[\033[38;5;197m\]╰─ \[\033[0m\]"
	alias cls='clear && fastfetch --raw ~/Bilder/FastFetch/image.bin --color green'
else
	clear
	export PS1="\033[38;5;197m\033[48;5;197;30m  .../\W \033[0m\033[38;5;197m \033[0m"
	alias cls='clear'
fi

# Aliases
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lah'
alias lzd='sudo lazydocker'
alias docker='sudo docker'

# Autostart
export PATH="/home/smuely/.local/bin:$PATH"
cls

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
