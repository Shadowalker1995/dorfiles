# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# You may need to manually set your language environment
#export LANG=zh_CN.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
#ZSH_THEME="robbyrussell"
#ZSH_THEME="amuse"
ZSH_THEME="solus"
 #ZSH_THEME="ys"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git extract z wd web-search rand-quote themes gitignore cp zsh_reload safe-paste colored-man-pages python history-substring-search zsh-syntax-highlighting last-working-dir zsh-256color alias-tips zsh-autopair git-open zsh-autosuggestions zsh-navigation-tools calc
)

#ZSH_TMUX_AUTOSTART=false
#ZSH_TMUX_AUTOSTART_ONCE=true
#ZSH_TMUX_AUTOCONNECT=false

# Preferred editor for local and remote sessions
export EDITOR='nvim'

export MANPATH="/usr/local/man:$MANPATH"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# To solve some program problems
export GIO_EXTRA_MODULES=/usr/lib/x86_64-linux-gnu/gio/modules/
export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/var/run/dbus/system_bus_socket
export QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

export DEFAULT_USER="zzhenry"

# added by Miniconda3 installer
#export PATH="$HOME/miniconda3/bin:$PATH"
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/miniconda3/lib
# export LD_LIBRARY_PATH=$HOME/anaconda3/pkgis/hdf5-1.10.1-h9caa474_1/lib:$LD_LIBRARY_PATH

export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH"
#export LD_LIBRARY_PATH="/usr/local/lib64:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$PATH:$HOME/miniconda3/bin"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export HOST=$(hostname)


# adde QT path
export PATH="/opt/Qt5.14.2/5.14.2/gcc_64/bin:$PATH"
export LD_LIBRARY_PATH=/opt/Qt5.14.2/5.14.2/gcc_64/lib:$LD_LIBRARY_PATH

#export PATH="/opt/Qt/5.15.2/gcc_64/bin:$PATH"
#export LD_LIBRARY_PATH=/opt/Qt/5.15.2/gcc_64/lib:$LD_LIBRARY_PATH

#export PATH="/opt/Qt/6.2.4/gcc_64/bin:$PATH"
#export LD_LIBRARY_PATH=/opt/Qt/6.2.4/gcc_64/lib:$LD_LIBRARY_PATH

# MATLAB
export PATH="/usr/local/MATLAB/R2022b/bin:$PATH"
export MATLAB_JAVA="/usr/lib/jvm/java-8-openjdk-amd64/jre/"

# cuda
export CUDA_HOME=/usr/local/cuda
export -U PATH=$CUDA_HOME/bin:$PATH
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH

# boost
export LD_LIBRARY_PATH=$HOME/Dev/Github/boost/stage/lib:$LD_LIBRARY_PATH

# python
#export PYTHONPATH=$HOME/miniconda3/lib/python3.7/site-packages

export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig

# export ANDROID_HOME=/usr/lib/android-sdk
export ANDROID_HOME=$HOME/Android/SDK
export -U PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

# export Google API Key
export GOOGLE_API_KEY="AIzaSyAp0kyOW_EympcH6LbjzqgkzFgfFms6CHM"
export GOOGLE_DEFAULT_CLIENT_ID="763551531709-isrgc7aq3ghl1fre9ina7vj34qblcrtd.apps.googleusercontent.com"
export GOOGLE_DEFAULT_CLIENT_SECRET="UBGXQcUakoNDDmi6d68EtRv8"

export TERM="tmux-256color"
#export TERM=xterm-256color
#export TERM=screen-256color

export WD_CONFIG=$HOME/.config/.warprc
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
#export LOCALBIN=$XDG_CONFIG_HOME/bin
#export PATH=$PATH:$LOCALBIN
export -U PATH="$HOME/bin:$PATH"
export -U PATH=$PATH:$HOME/.cargo/bin
#export PATH=$PATH:/usr/local/opt/node@12/bin
export TERM_ITALICS=true
export RANGER_LOAD_DEFAULT_RC="false"
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Environmental variables for Bsoft on Linux (x86_64)
BSOFT=$HOME/Dev/AITom/bsoft
BPARAM=$BSOFT/parameters/
export PATH=$BSOFT/bin:$PATH
export LD_LIBRARY_PATH=$BSOFT/lib:$LD_LIBRARY_PATH

# Golang
export GOPATH=$HOME/Dev/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# proxy
#export http_proxy="http://127.0.0.1:2080"
#export https_proxy="https://127.0.0.1:2080"

# Theano
export THEANO_FLAGS=blas.ldflags="-L/usr/lib/x86_64-linux-gnu/ -lblas"

export _Z_SRC="$HOME/.oh-my-zsh/plugins/z/z.sh"

# aliyunpan
export ALIYUNPAN_CONFIG_DIR=/home/zzhenry/Softwares/installed/aliyunpan/config

# 010editor
#export PATH=$PATH:/home/zzhenry/010editor
