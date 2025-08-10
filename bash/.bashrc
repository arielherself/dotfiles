# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# Path to your oh-my-bash installation.
export OSH='/home/nixos/.oh-my-bash'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
# OSH_THEME="slick"

# If you set OSH_THEME to "random", you can ignore themes you don't like.
# OMB_THEME_RANDOM_IGNORED=("powerbash10k" "wanelo")
# You can also specify the list from which a theme is randomly selected:
# OMB_THEME_RANDOM_CANDIDATES=("font" "powerline-light" "minimal")

# Uncomment the following line to use case-sensitive completion.
# OMB_CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# OMB_HYPHEN_SENSITIVE="false"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_OSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you don't want the repository to be considered dirty
# if there are untracked files.
# SCM_GIT_DISABLE_UNTRACKED_DIRTY="true"

# Uncomment the following line if you want to completely ignore the presence
# of untracked files in the repository.
# SCM_GIT_IGNORE_UNTRACKED="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.  One of the following values can
# be used to specify the timestamp format.
# * 'mm/dd/yyyy'     # mm/dd/yyyy + time
# * 'dd.mm.yyyy'     # dd.mm.yyyy + time
# * 'yyyy-mm-dd'     # yyyy-mm-dd + time
# * '[mm/dd/yyyy]'   # [mm/dd/yyyy] + [time] with colors
# * '[dd.mm.yyyy]'   # [dd.mm.yyyy] + [time] with colors
# * '[yyyy-mm-dd]'   # [yyyy-mm-dd] + [time] with colors
# If not set, the default value is 'yyyy-mm-dd'.
# HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if you do not want OMB to overwrite the existing
# aliases by the default OMB aliases defined in lib/*.sh
# OMB_DEFAULT_ALIASES="check"

# Would you like to use another custom folder than $OSH/custom?
# OSH_CUSTOM=/path/to/new-custom-folder

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=true

# To enable/disable display of Python virtualenv and condaenv
# OMB_PROMPT_SHOW_PYTHON_VENV=true  # enable
# OMB_PROMPT_SHOW_PYTHON_VENV=false # disable

# To enable/disable Spack environment information
# OMB_PROMPT_SHOW_SPACK_ENV=true  # enable
# OMB_PROMPT_SHOW_SPACK_ENV=false # disable

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

# If you want to reduce the initialization cost of the "tput" command to
# initialize color escape sequences, you can uncomment the following setting.
# This disables the use of the "tput" command, and the escape sequences are
# initialized to be the ANSI version:
#
#OMB_TERM_USE_TPUT=no

source "$OSH"/oh-my-bash.sh

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"
if [ $(which eza 2> /dev/null) ]; then
	alias ls=eza
	alias la='ls -lAhs modified --total-size'
else
	alias la='ls -lAhtr'
fi
if [ $(which batcat 2> /dev/null) ]; then
	alias cat=batcat
else if [ $(which bat 2> /dev/null) ]; then
	alias cat=bat
fi fi
alias diff='diff --color -u'
alias worddiff='wdiff -n -w $'\''\033[30;41m'\'' -x $'\''\033[0m'\'' -y $'\''\033[30;42m'\'' -z $'\''\033[0m'\'''
alias gc="git commit"
alias gl="git log"
alias gt="git tree"
alias gd="git diff"
alias gs="git status"
alias gp="git push"
alias gpl="git pull"
alias rgb="rg --smart-case --hidden -C 10 --pretty --no-config"
alias run-ip="ip -br -o -p -c -h a"
alias run-ftp="run-ip && unftp -v --root-dir=. --bind-address=0.0.0.0:2121 --bind-address-http=none --auth-type=anonymous"
alias run-install="yay -S --noconfirm"
alias run-uninstall="yay -R --noconfirm"
alias run-update="yay --noconfirm"
alias run-sshd="sudo /usr/sbin/sshd -Def /etc/ssh/sshd_config"
alias dx="distrobox"
run() {
	if [ $# -ge 1 ]; then
		rest="${@:2}"
		cmd="run-$1 $rest"
		bash -ic "set -x; $cmd"
	else
		echo "run: expected a word"
		return 1
	fi
}
me () { mkdir -p "$1" && cd "$1"; }

if [ -e /run/.containerenv ] || [ -e /.dockerenv ]; then
	# use separate history file for each container
	export PATH=$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin:$PATH
	export HISTFILE=$HOME/.bash_history_container_$CONTAINER_ID
	source $HOME/.distrobox-${CONTAINER_ID}-bashrc
fi

source ~/.git-prompt
shopt -s histappend
shopt -s nocaseglob
PROMPT_COMMAND='history -a;PS1_CMD1=$(__git_ps1 " (%s)")'
PS1='\n\[\e[38;5;244m\][\[\e[0m\]\t\[\e[38;5;244m\]] \[\e[38;5;157;1m\]\w\[\e[0m\]${PS1_CMD1}\[\e[38;5;39m\]${IN_NIX_SHELL:+ 󱄅 ${name}}\[\e[0m\]\[\e[38;5;220m\]${CONTAINER_ID:+ 󰆧 ${CONTAINER_ID}}\[\e[0m\]\n\[\e[0;38;5;208m\]$?\[\e[0;1m\]\$\[\e[0m\] '
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose
export GIT_PS1_SHOWCONFLICTSTATE=yes
export GIT_PS1_SHOWCOLORHINTS=1

bind 'set show-all-if-ambiguous on'

export PATH=$HOME/.cargo/bin:$PATH

export PAGER=less
export MANPAGER='nvim +Man!'
if [ -x /usr/bin/pyenv ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init - bash)"
fi

export NEKOAPI_KEY=$(cat $HOME/Dropbox/important/nekoapi_key)
export NEKOAPI_CLAUDE_KEY=$(cat $HOME/Dropbox/important/nekoapi_claude_key)
export ANTHROPIC_AUTH_TOKEN=$(cat $HOME/Dropbox/important/anyrouter_key)
export ANTHROPIC_BASE_URL=https://anyrouter.top

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

function cgtproxy-exec() {
  local slice="cgtproxy-$1.slice"
  shift 1
  systemd-run --user --slice "$slice" -P "$@"
}

# put it at the end of rc (don't know why)
eval "$(direnv hook bash)"

