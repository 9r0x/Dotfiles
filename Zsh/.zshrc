export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting ssh-agent)
source $ZSH/oh-my-zsh.sh
alias top='htop'

imgopt () {
	find $1 -type f -iname "*.png" -exec optipng -force -o7 {} && advpng -z4 {} \;
	find $1 -type f -iname "*.jpg" -exec jpegoptim -s --all-progressive {} \;
    find $1 -type f -iname "*.jpeg" -exec jpegoptim -s --all-progressive {} \;
}