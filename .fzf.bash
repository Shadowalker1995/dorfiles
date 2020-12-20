# Setup fzf
# ---------
if [[ ! "$PATH" == */home/zzhenry/.config/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/zzhenry/.config/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/zzhenry/.config/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/zzhenry/.config/.fzf/shell/key-bindings.bash"
