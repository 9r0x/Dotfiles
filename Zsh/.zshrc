export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting ssh-agent)
source $ZSH/oh-my-zsh.sh
alias top='htop'
alias e='emacs'
imgopt () {
	find $1 -type f -iname "*.png" -exec optipng -force -o7 {} && advpng -z4 {} \;
	find $1 -type f -iname "*.jpg" -exec jpegoptim -s --all-progressive {} \;
	find $1 -type f -iname "*.jpeg" -exec jpegoptim -s --all-progressive {} \;
}

savetodisk () {
	rsync -avh ~/.local/share/plasma-vault/H.enc/ /run/media/smellon/Ventoy/Backup/.system/H.enc/ --delete
	rsync -avh ~/.local/share/plasma-vault/SAVE.enc/ /run/media/smellon/Ventoy/Backup/.system/SAVE.enc/ --delete
}

o () {
    if [ $# -eq 0 ]; then
        set -- "."
    fi
    xdg-open $@ >/dev/null 2>&1
}

alias restartcam='echo -n "3-8" | sudo tee /sys/bus/usb/drivers/usb/unbind; sleep 3; echo -n "3-8" | sudo tee /sys/bus/usb/drivers/usb/bind'

alias vm='sudo systemctl start libvirtd; sudo virsh net-start default; sudo virsh list --all; sudo virsh start'

alias bat='awk "{print \$1*10^-6 \" W\"}" /sys/class/power_supply/BAT0/power_now'

export PATH=/home/smellon/nsight-systems-2023.4.1/bin:$PATH
