umask 0027

export LANG="en_GB.UTF-8"
export LC_TIME="de_CH.UTF-8"
export LC_TELEPHONE="de_CH.UTF-8"
export LC_MEASUREMENT="de_CH.UTF-8"

alias cls='clear && fastfetch --raw ~/Bilder/FastFetch/ArchLogoWithoutBackground.bin -c /usr/share/fastfetch/presets/examples/13.jsonc'
echo "IDE view? (y/n)"
read inp

if [[ $inp == "n" ]]
then
	PS1="\[\033[38;5;197m\]╭─\[\033[30;48;5;197m\] \w \[\033[38;5;197;40m\]  \d \[\033[30;48;5;197m\]  \t \[\033[38;5;197;40m\] ?? \$? \[\033[0;30;5;197m\]\n\[\033[38;5;197m\]╰─ \[\033[0m\]"
	alias cls='clear && fastfetch --raw ~/Bilder/FastFetch/ArchLogoWithoutBackground.bin -c /usr/share/fastfetch/presets/examples/13.jsonc'
else
	clear
	export PS1="\[\033[38;5;197m\]\[\033[48;5;197;30m\]  .../\W \[\033[0m\]\[\033[38;5;197m\] \[\033[0m\]"
	alias cls='clear'
fi

# LS_COLORS
# color .swp -files light grey
LS_COLORS="${LS_COLORS}*.swp=38\:5\:240:"
# color .o % .swp -files light grey
LS_COLORS="${LS_COLORS}*.o=38\:5\:240:"
# color .funny files pink
LS_COLORS="${LS_COLORS}*.funny=38\:5\:200:"
# color config files yellow
confColor="38\:5\:229"
LS_COLORS="${LS_COLORS}\
*.yml=${confColor}:\
*.cfg=${confColor}:\
*.conf=${confColor}:\
*.json=${confColor}:\
*.gitignore=${confColor}:\
*.toml=${confColor}:"
unset confColor
# possible secrets
secColor="38\:5\:46"
LS_COLORS="${LS_COLORS}\
*.env=${secColor}:\
*.secret=${secColor}:\
*.pwd=${secColor}:\
*.token=${secColor}:"
unset secColor

export LS_COLORS

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
