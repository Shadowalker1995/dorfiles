#! /bin/zsh

# create soft links
ln -snf $HOME/.config/dotfiles/alacritty $HOME/.config/alacritty
echo "alacritty"
ln -snf $HOME/.config/dotfiles/compton $HOME/.config/compton
echo "compton"
ln -snf $HOME/.config/dotfiles/i3 $HOME/.config/i3
echo "i3"
ln -snf $HOME/.config/dotfiles/i3block $HOME/.config/i3blocks
echo "i3block"
ln -snf $HOME/.config/dotfiles/i3status $HOME/.config/i3status
echo "i3status"
ln -snf $HOME/.config/dotfiles/neofetch $HOME/.config/neofetch
echo "neofetch"
ln -snf $HOME/.config/dotfiles/nvim $HOME/.config/nvim
echo "nvim"
ln -snf $HOME/.config/dotfiles/nvim $HOME/.vim
ln -snf $HOME/.config/dotfiles/nvim/init.vim $HOME/.vimrc
ln -snf $HOME/.config/dotfiles/polybar $HOME/.config/polybar
echo "polybar"
ln -snf $HOME/.config/dotfiles/py3status $HOME/.config/py3status
echo "py3status"
ln -snf $HOME/.config/dotfiles/ranger $HOME/.config/ranger
echo "ranger"
ln -snf $HOME/.config/dotfiles/rofi $HOME/.config/rofi
echo "rofi"
ln -snf $HOME/.config/dotfiles/zsh $HOME/.config/zsh
echo "zsh"
ln -snf $HOME/.config/dotfiles/.oh-my-zsh $HOME/.oh-my-zsh
echo "oh-my-zsh"
ln -snf $HOME/.config/dotfiles/.fzf $HOME/.config/.fzf
ln -snf $HOME/.config/dotfiles/.fzf.bash $HOME/.fzf.bash
ln -snf $HOME/.config/dotfiles/.fzf.zsh $HOME/.fzf.zsh
echo "fzf"

ln -snf $HOME/.config/dotfiles/.dir_colors $HOME/.dirc_colors
echo "dir_colors"
ln -snf $HOME/.config/dotfiles/.fonts $HOME/.fonts
echo "fonts"
ln -snf $HOME/.config/dotfiles/.goldendict $HOME/.goldendict
echo "goldendict"
ln -snf $HOME/.config/dotfiles/.picgo $HOME/.picgo
echo "picgo"
ln -snf $HOME/.config/dotfiles/.tmux $HOME/.tmux
ln -snf $HOME/.config/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -snf $HOME/.config/dotfiles/.tmux.conf.local $HOME/.tmux.conf.local
echo "tmux"

