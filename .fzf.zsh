# Setup fzf
# ---------
if [[ ! "$PATH" == */home/zzhenry/.config/dotfiles/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/zzhenry/.config/dotfiles/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/zzhenry/.config/dotfiles/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/zzhenry/.config/dotfiles/.fzf/shell/key-bindings.zsh"
