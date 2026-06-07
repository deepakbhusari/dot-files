# =========================================================
# 0. Q PRE BLOCK
# =========================================================
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] &&
  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# =========================================================
# 1. BOOT KERNEL (ABSOLUTE MINIMAL - MUST BE FAST)
# =========================================================

export EDITOR=vi
export TERM=xterm-256color
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE
bindkey -v
unsetopt XTRACE

# PATH SINGLE PASS
typeset -U path PATH
path=(
  /opt/homebrew/bin
  /usr/local/bin
  $HOME/.cargo/bin
  $HOME/.bun/bin
  $HOME/.console-ninja/.bin
  $path
)
export PATH

# =========================================================
# 2. TERMINAL OS STATE DIRECTORY (CORE INNOVATION)
# =========================================================

export ZRT_DIR="$HOME/.zrt"
mkdir -p "$ZRT_DIR"

export ZRT_CACHE="$ZRT_DIR/cache"
export ZRT_STATE="$ZRT_DIR/state"
export ZRT_PIPE="$ZRT_DIR/pipe"

mkdir -p "$ZRT_CACHE" "$ZRT_STATE"

# =========================================================
# 3. FAST ALIASES (NO COST AT BOOT)
# =========================================================

alias x="exit"
alias ls="lsd"
alias ll="lsd --long --sort time --reverse"
alias la="lsd -a --long --sort time --reverse"

alias g="rg --colors 'match:fg:magenta' 2>/dev/null"
alias hx="hexdump -C"
alias py="python3"
alias pyserver="python3 -m http.server 7777"

# git core
alias gs='git status'
alias gc='git commit -v'
alias gp='git pull --rebase'
alias gu='git push'
alias gd='git diff'

# =========================================================
# 4. ZRT DAEMON (BACKGROUND TERMINAL OS KERNEL)
# =========================================================

_zrt_daemon() {
  (
    while true; do
      # update tool cache state
      command -v git >/dev/null && echo "git" > "$ZRT_CACHE/git.ok"
      command -v rg  >/dev/null && echo "rg"  > "$ZRT_CACHE/rg.ok"
      command -v fd  >/dev/null && echo "fd"  > "$ZRT_CACHE/fd.ok"
      command -v lsd >/dev/null && echo "lsd" > "$ZRT_CACHE/lsd.ok"

      # heartbeat timestamp
      date +%s > "$ZRT_STATE/heartbeat"

      sleep 30
    done
  ) &!
}

# start daemon once per login session
[[ -z "$ZRT_DAEMON_STARTED" ]] && {
  export ZRT_DAEMON_STARTED=1
  _zrt_daemon
}

# =========================================================
# 5. LAZY LOADER ENGINE (COMMAND VIRTUALIZATION)
# =========================================================

_zrt_lazy() {
  local name="$1"
  shift

  eval "$name() {
    unset -f $name
    $*
  }"
}

# =========================================================
# 6. FZF (VIRTUALIZED - LOAD ON FIRST USE)
# =========================================================

_zrt_lazy fzf '
  [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] &&
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

  [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]] &&
    source /opt/homebrew/opt/fzf/shell/completion.zsh

  command fzf "$@"
'

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

# =========================================================
# 7. AUTOSUGGESTIONS (EVENT DRIVEN)
# =========================================================

_autosuggest_loaded=0
load_autosuggest() {
  [[ $_autosuggest_loaded -eq 1 ]] && return
  _autosuggest_loaded=1
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
}
autoload -U add-zsh-hook
add-zsh-hook precmd load_autosuggest

# =========================================================
# 8. COMPINIT (DECOUPLED BACKGROUND CACHE BUILD)
# =========================================================

_zrt_compinit() {
  (
    autoload -Uz compinit
    compinit -C
  ) &!
}

[[ -z "$ZRT_COMPINIT_DONE" ]] && {
  export ZRT_COMPINIT_DONE=1
  _zrt_compinit
}

# =========================================================
# 9. ZOXIDE (FAST PATH ENGINE)
# =========================================================
eval "$(/opt/homebrew/bin/zoxide init zsh)"
alias zq="zoxide query -ls"

# =========================================================
# 10. TERMINAL OS HOOK SYSTEM
# =========================================================

_zrt_precmd() {
  # ultra-light prompt hook (NO FORKS)
  # only reads cached state
  [[ -f "$ZRT_STATE/heartbeat" ]] || return
}

add-zsh-hook precmd _zrt_precmd

# =========================================================
# 11. OPTIONAL TOOLCHAIN (NEVER BLOCK BOOT)
# =========================================================

export PYENV_ROOT="$HOME/.pyenv"

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# =========================================================
# 12. PERFORMANCE SAFETY
# =========================================================

unsetopt XTRACE

# =========================================================
# Q POST BLOCK
# =========================================================
#[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] &&
#  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# Git branch function
parse_git_branch() {
  git branch 2>/dev/null | sed -n 's/* \(.*\)/(\1)/p'
}

#Enable prompt substitution
setopt PROMPT_SUBST

#PS1 with folder path and git branch
PS1='%F{cyan}%/%f %F{yellow}$(parse_git_branch)%f %F{green}->%f '

