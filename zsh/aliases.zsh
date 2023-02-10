# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nvim $HOME/.config/zsh/{.zshrc,env.zsh,aliases.zsh}"
alias tmuxconfig="nvim $HOME/{.tmux.conf,.tmux.conf.local}"
alias i3config="nvim $HOME/.config/i3/conf.d/*.conf $HOME/.config/i3/config"
alias alacrittyconfig="nvim $HOME/.config/alacritty/alacritty.yml"
alias raconfig="nvim $HOME/.config/ranger/{rc.conf,rifle.conf,scope.sh,commands.py,commands_full.py}"
alias ohmyzsh="nvim $HOME/.oh-my-zsh/oh-my-zsh.sh"
alias cs='calcurse'
alias de='conda deactivate'
alias lg='lazygit'
alias ra='ranger'
alias sra='sudo -E ranger'
alias s='neofetch'
alias c="clear"
alias df='df -H'
alias du='ncdu --color dark'
#alias cat='pygmentize -g'
alias bat='bat --paging=never'
alias fzf="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias unzip="unzip -O cp936"
alias myip="curl http://ipecho.net/plain; echo"
alias ping="ping -c 5"
alias wget='wget -c'
alias reload="source $HOME/.config/zsh/.zshrc"
alias sap="sudo apt-get "
alias mkdir="mkdir -pv"
alias diff="colordiff"
alias sha1="openssl sha1"
alias ports="netstat -tulanp"
alias echopath='echo -e ${PATH//:/\\n}'
alias echolib='echo -e ${LD_LIBRARY_PATH//:/\\n}'
# do not delete / or prompt if deleting more than 3 files at a time #
#alias rm='rm -I --preserve-root'
#alias rm='trash'
# confirmation #
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'

# ssh servers
alias aliyun='sshpass -p 95218zz!!0130 ssh root@149.129.119.6'
alias vultr="sshpass -p 'oG=8bxq9ornsD?pr' ssh root@108.61.205.162"
alias pi="sshpass -p 'zgl19950218' ssh -p 7006 zzhenry@106.54.186.223"
alias pilocal="sshpass -p 'zgl19950218' ssh zzhenry@192.168.1.223"
alias tencent="ssh ubuntu@106.54.186.223"
alias ssh_oracle="ssh ubuntu@158.101.153.138"
#alias sshxulab="ssh -p 20022 v_zhu_zhan@xulab-gpu0.pc.cs.cmu.edu"
alias sshgpu0="ssh -p 20022 v_zhu_zhan@xulab-gpu0.pc.cc.cmu.edu -L 127.0.0.1:1234:127.0.0.1:8888"
alias sshgpu1="ssh -p 20022 v_zhu_zhan@xulab-gpu1.pc.cc.cmu.edu -L 127.0.0.1:1234:127.0.0.1:8888"
alias ssh171="ssh -p 8443 v_zhu_zhan@124.16.75.172 -L 127.0.0.1:1234:127.0.0.1:8888"
# foreign server
#alias ssh5007="ssh -p 7002 zzhenry@45.63.53.116"
# oracle server
#alias ssh5007="ssh -p 7001 zzhenry@158.101.153.138"
# tencent server
alias ssh5007="ssh -p 7001 zzhenry@106.54.186.223"
alias ssh5007local="ssh -p 8088 zzhenry@10.206.220.189"
#alias ssh5007="ssh -p 7001 zzhenry@72.95.243.161"

# frp
alias frpc_tencent="nohup $HOME/Softwares/system/frp/frpc -c $HOME/Softwares/system/frp/frpc_tencent.ini > $HOME/Softwares/system/frp/frpc_tencent.out 2>&1 &"
alias frpc_oracle="nohup $HOME/Softwares/system/frp/frpc -c $HOME/Softwares/system/frp/frpc_oracle.ini > $HOME/Softwares/system/frp/frpc_oracle.out 2>&1 &"
alias frps="nohup $HOME/Softwares/system/frp/frps -c $HOME/Softwares/system/frp/frps_full.ini &"
alias frpout_oracle="cat $HOME/Softwares/system/frp/frpc_oracle.out"
alias frpout_tencent="cat $HOME/Softwares/system/frp/frpc_tencent.out"
alias chfs8082="chfs --file=$HOME/Softwares/installed/chfs/config_Root_8082.ini > /dev/null"
alias py27='/usr/bin/python2.7'
alias opentp='sudo modprobe psmouse'        # open touchpad
alias boot_windows='efibootmgr | grep "Windows Boot Manager" | tail -n 1 | head -c 8 | tail -c 4 |  xargs sudo efibootmgr -n'
alias closetp='sudo modprobe -r psmouse'    # close touchpad
alias closescreen='xset dpms force off'     # close screen
alias hdmionly='xrandr --output HDMI-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output eDP-1-1 --off'
alias screenonly='xrandr --output HDMI-0 --off --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output eDP-1-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal'
alias twoscreen='xrandr --output HDMI-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal'
alias update_chrome='sudo apt-get --only-upgrade install google-chrome-stable'
alias proxypool='ProxyPool.py'
#alias typora="open -a typora"
#alias win10='virsh --connect qemu:///system start win10-new'
#alias win10='virsh start win10-new && virt-viewer win10-new'
alias aliDrive="$HOME/Softwares/installed/AliDrive/AliDrive"
alias x11vnc="x11vnc -usepw -noxdamage -forever -auth ~/.Xauthority -display :1"
alias aliyun-webdav="/home/zzhenry/Softwares/installed/aliyunpan/webdav.sh"
alias aliyun-sync="/home/zzhenry/Softwares/installed/aliyunpan/sync.sh"
alias scrcpy="scrcpy -s 10.206.113.188 -b 16M --always-on-top --prefer-text --turn-screen-off --window-borderless --window-title Honor-V20 --push-target /storage/emulated/0/zzhenry"
alias matlab-cli="matlab -nodesktop -nosplash"
