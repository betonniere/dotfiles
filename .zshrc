# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#export PATH="$HOME/Project/Cross/Osxcross/target/bin:$PATH"
#export PATH="$HOME/Project/Cross/Osxcross/build/cctools-895-ld64-274.2_8e9c3f2/cctools/misc:$PATH"
#export PATH="$HOME/Project/Cross/Osxcross/build/cctools-port/cctools/otool:$PATH"
#export MACOSX_DEPLOYMENT_TARGET=10.6

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="yannick"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.oh-my-zsh.custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode)
plugins+=(history)
plugins+=(zsh-navigation-tools)
plugins+=(colored-man-pages)
plugins+=(git-open)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export ATEMELIB=$HOME/Work/Ateme
export ATEME_WORKSPACE=$HOME/Work/checkouts
export ATEMENAME=yleroux
export SCHROOT_CHROOT_IMAGE=buster-amd64-v3.tar.bz2
#export SCHROOT_CHROOT_IMAGE=buster-clang-amd64-v3.tar.bz2
export PYTHONPATH=$HOME/Work/test-framework/src
#export LD_LIBRARY_PATH=$HOME/Work/TitanProcessing/bin:$HOME/Work/Ateme/x64-buster-clang/bin
export LD_LIBRARY_PATH=$HOME/Work/TitanProcessing/bin:$HOME/Work/Ateme/x64-buster/bin
export ANDROID_HOME=$HOME/Android/Sdk
export HOSTALIASES=$HOME/.ssh/hosts

path[1,0]=($HOME/.local/bin $ANDROID_HOME/platform-tools)
