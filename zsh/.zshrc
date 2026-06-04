# =========================================================
# 0. Q PRE BLOCK
# =========================================================
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] &&
  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# =========================================================
# 1. BOOT STRAP LAYER (MUST BE <10ms)
# =========================================================

export EDITOR=vi
export TERM=xterm-256color

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

bindkey -v

# PATH (single pass, no recomputation)
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

unsetopt XTRACE

# minimal aliases only
alias x="exit"
alias g="rg --colors 'match:fg:magenta' 2>/dev/null"

# =========================================================
# 2. LAZY LOADER ENGINE (CORE INNOVATION)
# =========================================================

_lazy_load() {
  local cmd="$1"
  shift

  eval "$cmd() {
    unset -f $cmd
    $*
  }"
}

# =========================================================
# 3. FZF (LAZY + ONE-TIME INIT)
# =========================================================

_lazy_load fzf '
  [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] &&
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

  [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]] &&
    source /opt/homebrew/opt/fzf/shell/completion.zsh

  command fzf "$@"
'

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

# =========================================================
# 4. AUTOSUGGESTIONS (DEFERRED ON FIRST PROMPT)
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
# 5. COMPINIT (ASYNC BACKGROUND CACHE)
# =========================================================

compinit_async() {
  (
    autoload -Uz compinit
    compinit -C
  ) &!
}

# run AFTER shell starts (non-blocking)
compinit_async

# =========================================================
# 6. ASYNC SYSTEM WARMUP ENGINE
# =========================================================

_shell_warmup() {
  (
    command -v git >/dev/null
    command -v rg >/dev/null
    command -v fd >/dev/null
    command -v lsd >/dev/null
    command -v python3 >/dev/null
  ) &!
}

_shell_warmup

# =========================================================
# 7. ZOXIDE (FAST PATH TOOL)
# =========================================================
eval "$(/opt/homebrew/bin/zoxide init zsh)"
alias zq="zoxide query -ls"

# =========================================================
# 8. LIGHTWEIGHT DEV ALIASES
# =========================================================

alias ls="lsd"
alias ll="lsd --long --sort time --reverse"
alias la="lsd -a --long --sort time --reverse"

alias dus="du -hs . 2>/dev/null"
alias d="dust -T 8 -B"

alias py="python3"
alias pyserver="python3 -m http.server 7777"

# git minimal
alias gs='git status'
alias gc='git commit -v'
alias gp='git pull --rebase'
alias gu='git push'
alias gd='git diff'

# =========================================================
# 9. FAST FUNCTIONS (NO SPAWN CHAINS)
# =========================================================

dir_size() { du -hsx "$1" }
fld() { fold -s -w "$1" "$2" > "$3" }
f1() { find . -type f -size +"$1" -exec ls -sh {} \; 2>/dev/null }
c() { clang -std=c2x -Wall -Wextra -pedantic "$@" }

sd() { sed "s/\(.*\) \(.*\)/\1$1 \2/" "$2" }

# =========================================================
# 10. OPTIONAL HEAVY TOOLS (NEVER BLOCK BOOT)
# =========================================================

# pyenv (lazy safe)
export PYENV_ROOT="$HOME/.pyenv"

# mise (only if externally prepared)
[[ -n $ZSH_MISE_LOADED ]] && eval "$(mise activate zsh --shims)"

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
# 11. EVENT-DRIVEN LAYER (POST PROMPT HOOKS)
# =========================================================

_post_prompt_once=0
_post_prompt_init() {
  [[ $_post_prompt_once -eq 1 ]] && return
  _post_prompt_once=1

  # future hook space (git prompt, metrics, etc.)
}

add-zsh-hook precmd _post_prompt_init

# =========================================================
# 12. FINAL SAFETY
# =========================================================

unsetopt XTRACE

# =========================================================
# Q POST BLOCK
# =========================================================
#[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] &&
#  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

