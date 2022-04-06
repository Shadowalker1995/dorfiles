source ~/.config/zsh/env.zsh
source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/aliases.zsh
#source ~/.config/zsh/plugins.zsh
#source ~/.config/zsh/vi.zsh
#source ~/.config/zsh/fzf.zsh
#source ~/.config/zsh/mappings.zsh

# User configuration
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# dynpaper
# dynpaper -f $HOME/Pictures/Mojave/mojave_dynamic_{}.jpeg -e gnome &

# add completion for alacritty
fpath+=$HOME/.config/.zsh_functions

# thefuck init
eval $(thefuck --alias)

# 真彩色显示zsh下ls命令展示的内容
eval `dircolors ~/.dir_colors/dircolors`

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tmux
#if which tmux 2>&1 >/dev/null; then
  #if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
    ##tmux attach -t main || tmux new -s main
    #tmux new -s main || clear; tmux new
  #fi
#fi
if ! ps -p $PPID | grep -q java; then
    if [ -z "$TMUX" ]; then
        base_session='main'
        # Create a new session if it doesn't exist
        tmux has-session -t $base_session || tmux new-session -d -s $base_session
        # Are there any clients connected already?
        client_cnt=$(tmux list-clients | wc -l)
        if [ $client_cnt -ge 1 ]; then
            session_name=$base_session"-"$client_cnt
            tmux new-session -d -s $session_name
            tmux -2 attach-session -t $session_name \; set-option destroy-unattached
        else
            tmux -2 attach-session -t $base_session
        fi
    fi
fi

# zranger
autoload -U zranger
bindkey -s '\ez' "\eq zranger\n"

#quote | cowsay
#fortune -e chinese | cowsay

s
