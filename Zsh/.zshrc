export ZSH="$HOME/.oh-my-zsh"
export VISUAL=emacs
export EDITOR="$VISUAL"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$DYLD_LIBRARY_PATH

ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv user dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time status time)
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\u2570%F{255}\uF460%F{250}\uF460%F{245}\uF460%f "
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\uE0B4"

plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

PATH="/usr/local/opt/sqlite/bin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/sbin:$PATH"
#VIRTUALENVWRAPPER_PYTHON=$(which python3)
source `which virtualenvwrapper.sh`

alias e='emacsclient -t'
alias top='htop'
alias eslint='./node_modules/.bin/eslint'
alias ma='wolframscript'

to_gif () {
    ffmpeg -y -i $1 -vf fps=10,scale=320:-1:flags=lanczos,palettegen palette.png
    ffmpeg -i $1 -i palette.png -filter_complex "fps=10,scale=320:-1:flags=lanczos[x];[x][1:v]paletteuse" output.gif
    rm palette.png
}

p () {
    export http_proxy=http://127.0.0.1:1087
    export https_proxy=http://127.0.0.1:1087
}

pl () {
    export http_proxy=http://127.0.0.1:56278
    export https_proxy=http://127.0.0.1:56278
}

update () {
    brew upgrade
    brew cask upgrade
    upgrade_oh_my_zsh
}

sys_proxy () {
    if [ "$1" = "status" ]; then
	networksetup -getsocksfirewallproxy wi-fi
    elif [ "$1" = "off" ]; then
	networksetup -setsocksfirewallproxystate wi-fi off
	networksetup -getsocksfirewallproxy wi-fi
    elif [ "$1" = "on" ]; then
	networksetup -setsocksfirewallproxystate wi-fi on
	networksetup -setsocksfirewallproxy wi-fi localhost $2
	networksetup -getsocksfirewallproxy wi-fi
    fi
}

testnet (){
    curl -s https://api.ip.sb/geoip | jq -r '.ip + " " + .country'
}

# ls -> exa
# cat -> bat

