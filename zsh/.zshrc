# =========================================================
# 0. Q PRE BLOCK (KEEP TOP)
# =========================================================
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] &&
  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# =========================================================
# 1. CORE ENV
# =========================================================
export EDITOR=vi
export TERM=xterm-256color
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE
unsetopt XTRACE
bindkey -v

# =========================================================
# 2. PATH (FAST SINGLE PASS)
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
# 3. BASIC ALIASES
# =========================================================
alias x="exit"

alias ls="lsd"
alias ll="lsd --long --sort time --reverse"
alias la="lsd -a --long --sort time --reverse"

alias dus="du -hs . 2>/dev/null"
alias d="dust -T 8 -B"

alias de="arch -arm64 ~/.config/emacs/bin/doom emacs"

alias g="rg --colors 'match:fg:magenta' 2>/dev/null"
alias hx="hexdump -C"

alias py="python3"
alias pyserver="python3 -m http.server 7777"

# git
alias gb="git branch"
alias gs="git status"
alias gc="git commit -v"
alias gp="git pull --rebase"
alias gu="git push"
alias gd="git diff"
alias gl="git log --stat"
alias glo="git log --oneline --graph --decorate --all"

# =========================================================
# 4. FUNCTIONS
# =========================================================
fld() { fold -s -w "$1" "$2" > "$3" }
dir_size() { du -hsx "$1" }

f1() {
  find . -type f -size +"$1" -exec ls -sh {} \; 2>/dev/null
}

c() { clang -std=c2x -Wall -Wextra -pedantic "$@" }

sd() { sed "s/\(.*\) \(.*\)/\1$1 \2/" "$2" }

sdb() { sed "s/\(num\)\(.*r\)/\1->\2/" "$2" }

# =========================================================
# 5. RELIABLE GIT PROMPT ENGINE (FIXED)
# =========================================================

GIT_BRANCH_CACHE=""

_git_branch() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  git symbolic-ref --quiet --short HEAD 2>/dev/null ||
  git rev-parse --short HEAD 2>/dev/null
}

_git_update() {
  local b="$(_git_branch)"
  if [[ -n "$b" ]]; then
    GIT_BRANCH_CACHE="$b"
  else
    GIT_BRANCH_CACHE=""
  fi
}

autoload -U add-zsh-hook

# runs before each prompt (safe + fast)
_git_precmd() {
  _git_update
}

add-zsh-hook precmd _git_precmd

# =========================================================
# 6. CLEAN PROMPT (NO SPAM, NO BLANK NOISE)
# =========================================================

setopt PROMPT_SUBST

PROMPT='%F{cyan}%d%f %F{yellow}${GIT_BRANCH_CACHE:+$GIT_BRANCH_CACHE }%f%F{green}→%f '

# =========================================================
# 7. ZOXIDE
# =========================================================
eval "$(/opt/homebrew/bin/zoxide init zsh)"
alias zq="zoxide query -ls"

# =========================================================
# 8. OPTIONAL TOOLCHAINS (SAFE)
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
# 9. Q POST BLOCK (KEEP BOTTOM)
# =========================================================
#[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] &&
#  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

eval "$(mise activate zsh)"

