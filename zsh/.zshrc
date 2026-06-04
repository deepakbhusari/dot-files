# =========================================================
# Q PRE BLOCK (DO NOT MOVE)
# =========================================================
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] &&
  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# =========================================================
# BOOT CORE (ABSOLUTELY MINIMAL)
# =========================================================
export EDITOR=vi
export TERM=xterm-256color
export XDG_CONFIG_HOME="$HOME/.config"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE

bindkey -v

# =========================================================
# PATH (FAST SINGLE SOURCE)
# =========================================================
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
# PERFORMANCE FLAGS
# =========================================================
unsetopt XTRACE

# =========================================================
# CORE ALIASES (ZERO DEP COST)
# =========================================================
alias ls="lsd"
alias ll="lsd --long --sort time --reverse"
alias la="lsd -a --long --sort time --reverse"

alias dus="du -hs . 2>/dev/null"
alias d="dust -T 8 -B"
alias g="rg --colors 'match:fg:magenta' 2>/dev/null"
alias gr="rg --colors 'match:fg:magenta' 2>/dev/null"

alias hx="hexdump -C"
alias h="history 100 | rg "
alias hv="history | vi"
alias x="exit"

alias py="python3"
alias pyserver="python3 -m http.server 7777"

# =========================================================
# FAST FUNCTIONS
# =========================================================
dir_size() { du -hsx "$1" }
fld() { fold -s -w "$1" "$2" > "$3" }
f1() { find . -type f -size +"$1" -exec ls -sh {} \; 2>/dev/null }
c() { clang -std=c2x -Wall -Wextra -pedantic "$@" }
sd() { sed "s/\(.*\) \(.*\)/\1$1 \2/" "$2" }

# =========================================================
# ASYNC ENGINE (CORE INNOVATION)
# =========================================================
_async_loaded=0
_async_init_done=0

run_async() {
  # run in background, detached from prompt
  ( "$@" >/dev/null 2>&1 & )
}

# =========================================================
# 1. COMPINIT (ASYNC + CACHED)
# =========================================================
load_compinit_async() {
  [[ -n $_async_init_done ]] && return
  _async_init_done=1

  run_async zsh -c '
    autoload -Uz compinit
    compinit -C
  '
}

# =========================================================
# 2. FZF (LAZY + ASYNC WARMUP)
# =========================================================
_fzf_loaded=0
load_fzf() {
  [[ $_fzf_loaded -eq 1 ]] && return
  _fzf_loaded=1

  [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] &&
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

  [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]] &&
    source /opt/homebrew/opt/fzf/shell/completion.zsh
}

fzf() {
  load_fzf
  command fzf "$@"
}

# =========================================================
# 3. AUTOSUGGESTIONS (DEFERRED)
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
# 4. ZOXIDE (FAST INIT)
# =========================================================
eval "$(/opt/homebrew/bin/zoxide init zsh)"
alias zq="zoxide query -ls"

# =========================================================
# 5. GIT SHORTCUTS
# =========================================================
alias gs='git status'
alias gc='git commit -v'
alias gp='git pull --rebase'
alias gu='git push'
alias gb='git branch'
alias gd='git diff'

# =========================================================
# 6. BACKGROUND WARMUP THREAD (IMPORTANT)
# =========================================================
_shell_warmup_done=0

_shell_warmup() {
  [[ $_shell_warmup_done -eq 1 ]] && return
  _shell_warmup_done=1

  run_async /bin/sh -c '
    # warm caches
    command -v git >/dev/null
    command -v rg >/dev/null
    command -v fd >/dev/null
    command -v lsd >/dev/null
  '
}

_shell_warmup &!

# =========================================================
# 7. OPTIONAL TOOLS (DO NOT BLOCK BOOT)
# =========================================================
export PYENV_ROOT="$HOME/.pyenv"

# mise lazy
if [[ -n $ZSH_MISE_LOADED ]]; then
  eval "$(mise activate zsh --shims)"
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# =========================================================
# 8. OPTIONAL TMUX
# =========================================================
export TMUX=screen-256color
alias tx="tmux a -t dev || tmux new -t dev"

# =========================================================
# 9. SAFETY (NO DEBUG MODE LEAKS)
# =========================================================
unsetopt XTRACE

# =========================================================
# Q POST BLOCK
# =========================================================
#[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] &&
#  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

