# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="nvim ~/.config/zsh/.zshrc ~/.config/zsh/env.zsh ~/.config/zsh/aliases.zsh"
alias i3config="vim ~/.config/i3/config"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias cs='calcurse'
alias de='conda deactivate'
alias lg='lazygit'
alias ra='ranger'
alias sra='sudo -E ranger'
alias s='neofetch'
#alias rm="trash"
alias c="clear"
#alias cp="cp -i"
alias df='df -h'
alias du='ncdu'
#alias cat='bat'
alias unzip='unzip -O cp936'
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
alias ssh5007="ssh -p 6002 zzhenry@121.36.222.86"
#alias ssh5007="ssh -p 7001 zzhenry@72.95.243.161"
alias frp="nohup ~/Softwares/system/frp/frpc -c ~/Softwares/system/frp/frpc_tencent.ini > ~/Softwares/system/frp/nohup.out 2>&1 &"
alias frps="nohup ~/Softwares/system/frp/frps -c ~/Softwares/system/frp/frps_full.ini &"
alias frpout="cat ~/Softwares/system/frp/nohup.out"
alias chfs8081="chfs --file=$HOME/Softwares/installed/chfs/config_local6V_8081.ini"
alias chfs8082="chfs --file=$HOME/Softwares/installed/chfs/config_Medias_8082.ini"
alias chfs8083="chfs --file=$HOME/Softwares/installed/chfs/config_2T_8083.ini"
alias chfs8084="chfs --file=$HOME/Softwares/installed/chfs/config_freecourse_8084.ini"
alias chfs8085="chfs --file=$HOME/Softwares/installed/chfs/config_S_8085.ini"
alias py27='/usr/bin/python2.7'
alias opentp='sudo modprobe psmouse'		# open touchpad
alias closetp='sudo modprobe -r psmouse'	# close touchpad
alias closescreen='xset dpms force off'		# close screen
alias hdmionly='xrandr --output HDMI-0 --auto --output eDP-1-1 --off'
alias screenonly='xrandr --output eDP-1-1 --auto --output HDMI-0 --off'
alias twoscreen='xrandr --output HDMI-0 --auto --right-of eDP-1-1 --auto'
alias update_chrome='sudo apt-get --only-upgrade install google-chrome-stable'
alias proxypool='ProxyPool.py'
#alias typora="open -a typora"
#alias win10='virsh --connect qemu:///system start win10-new'
alias win10='virsh start win10-new && virt-viewer win10-new'
