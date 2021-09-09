# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
git
tmux
colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# Enable fzf if it's installed
if [ -f ~/.fzf.zsh ]; then
  # Load FZF
  source ~/.fzf.zsh

  # Show preview window when running Alt+C to change directory
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

  # Load FZF ZSH tab completion plugin if it exists
  # It adds FZF to all tab completions overriding the default menu
  FZF_TAB_COMPLETION_PATH=~/.fzf-tab-completion/zsh/fzf-zsh-completion.sh
  if [ -f $FZF_TAB_COMPLETION_PATH ]; then
    source $FZF_TAB_COMPLETION_PATH
    zstyle ':completion:*' fzf-search-display true
  fi

  _fzf_comprun() {
    local command=$1
    shift

    case "$command" in
      cd) fzf "$@" --preview 'tree -C {} | head -200' ;;
      export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
      *)  fzf "$@" ;;
    esac
  }

  # Run `fzf_apropos` to search available commands/descriptions and display their man pages
  function fzf_apropos() {
    apropos '' | fzf --preview-window=up:50% --preview 'echo {} | cut -f 1 -d " " | xargs man' | cut -f 1 -d " "
  }

fi

# Example aliases
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vimconfig="vim ~/.vim/vimrc"

# Use neovim instead of vim if installed
if which nvim &> /dev/null; then
  alias vim=nvim
  export EDITOR=/bin/nvim
fi

if [ $USER = "toni" ]; then
  alias ssh='TERM=xterm-256color ssh'
fi

# Powerlevel10k prompt
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Ruby environment configuration

if [ $USER = "tvapalo" ]; then

  export PATH="$HOME/.rbenv/bin:$PATH"
  eval export PATH="/home/tvapalo/.rbenv/shims:${PATH}"
  export RBENV_SHELL=zsh
  source $HOME/.rbenv/libexec/../completions/rbenv.zsh
  command rbenv rehash 2>/dev/null
  rbenv() {
    local command
    command="${1:-}"
    if [ "$#" -gt 0 ]; then
      shift
    fi
  case "$command" in
  rehash|shell)
    eval "$(rbenv "sh-$command" "$@")";;
  *)
    command rbenv "$command" "$@";;
  esac
}
fi

# Highlite plugin source
source ~/highlite/highlite.plugin.zsh

