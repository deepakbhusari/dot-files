# =========================================================
# 0. OPTIONAL PROFILING
# =========================================================
# zmodload zsh/zprof

# =========================================================
# 1. CORE ENV (ULTRA LIGHT)
# =========================================================

export EDITOR=vi
export TERM=xterm-256color

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE
bindkey -v
unsetopt XTRACE

# =========================================================
# 2. PATH (NO OVERHEAD)
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
# 3. CORE ALIASES (FAST PATH ONLY)
# =========================================================

alias x="exit"

alias ls="lsd"
alias ll="lsd --long --sort time --reverse"
alias la="lsd -a --long --sort time --reverse"

alias g="rg --colors 'match:fg:magenta' 2>/dev/null"
alias hx="hexdump -C"

alias py="python3"
alias pyserver="python3 -m http.server 7777"

# git core (FAST)
alias gs="git status"
alias gc="git commit -v"
alias gp="git pull --rebase"
alias gu="git push"
alias gd="git diff"
alias gb="git branch"   # ✅ ADDED (your request)

# =========================================================
# 4. FAST FUNCTIONS (NO PROMPT USAGE)
# =========================================================

dir_size() { du -hsx "$1" }
fld() { fold -s -w "$1" "$2" > "$3" }

f1() {
  find . -type f -size +"$1" -exec ls -sh {} \; 2>/dev/null
}

c() { clang -std=c2x -Wall -Wextra -pedantic "$@" }

sd() { sed "s/\(.*\) \(.*\)/\1$1 \2/" "$2" }

sdb() { sed "s/\(num\)\(.*r\)/\1->\2/" "$2" }

# =========================================================
# 5. ZOXIDE (FAST)
# =========================================================

eval "$(/opt/homebrew/bin/zoxide init zsh)"
alias zq="zoxide query -ls"

# =========================================================
# 6. FZF (LAZY LOAD)
# =========================================================

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

_fzf_loaded=0
fzf() {
  if [[ $_fzf_loaded -eq 0 ]]; then
    _fzf_loaded=1

    [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] &&
      source /opt/homebrew/opt/fzf/shell/key-bindings.zsh

    [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]] &&
      source /opt/homebrew/opt/fzf/shell/completion.zsh
  fi

  command fzf "$@"
}

# =========================================================
# 7. AUTOSUGGESTIONS (LAZY, NON-BLOCKING)
# =========================================================

_autosuggest_loaded=0

load_autosuggest() {
  [[ $_autosuggest_loaded -eq 1 ]] && return
  _autosuggest_loaded=1
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd load_autosuggest

# =========================================================
# 8. TOOLCHAINS (NON-BLOCKING)
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
# 9. ⚡ FAST PROMPT (NO GIT FORK)
# =========================================================

autoload -Uz add-zsh-hook
setopt PROMPT_SUBST

GIT_BRANCH=""

update_git_branch() {
  GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
}

precmd() {
  update_git_branch
}

PS1='%F{cyan}%/%f %F{yellow}${GIT_BRANCH:+($GIT_BRANCH)}%f %F{green}->%f '

# =========================================================
# 10. OPTIONAL COMPLETION (DISABLED FOR SPEED)
# =========================================================
# autoload -Uz compinit
# compinit

# =========================================================
# 11. FINAL SAFETY
# =========================================================

unsetopt XTRACE

