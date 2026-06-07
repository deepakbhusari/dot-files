# =========================================================
# 0. Q PRE BLOCK (KEEP TOP)
# =========================================================
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] &&
  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# =========================================================
# 1. CORE ENV (MINIMAL BOOT COST)
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
# 2. PATH (SINGLE PASS, FAST)
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
# 3. FAST ALIASES (ZERO LOAD COST)
# =========================================================
alias x="exit"

alias ls="lsd"
alias ll="lsd --long --sort time --reverse"
alias la="lsd -a --long --sort time --reverse"

alias dus="du -hs . 2>/dev/null"
alias d="dust -T 8 -B"

alias g="rg --colors 'match:fg:magenta' 2>/dev/null"
alias hx="hexdump -C"

alias py="python3"
alias pyserver="python3 -m http.server 7777"

# REQUIRED
alias gb="git branch"

alias gs="git status"
alias gc="git commit -v"
alias gp="git pull --rebase"
alias gu="git push"
alias gd="git diff"

# =========================================================
# 4. FAST FUNCTIONS (NO HEAVY DEP)
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
# 5. FAST GIT PROMPT (OPTION C — LIGHTWEIGHT)
# =========================================================
parse_git_branch() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  git symbolic-ref --quiet --short HEAD 2>/dev/null ||
  git rev-parse --short HEAD 2>/dev/null
}

setopt PROMPT_SUBST

PS1='%F{cyan}%d%f %F{yellow}$(parse_git_branch)%f %F{green}->%f '

# =========================================================
# 6. ZOXIDE (FAST NAVIGATION)
# =========================================================
eval "$(/opt/homebrew/bin/zoxide init zsh)"
alias zq="zoxide query -ls"

# =========================================================
# 7. FZF (LAZY LOAD - IMPORTANT FOR SPEED)
# =========================================================
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

fzf() {
  unset -f fzf
  [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] &&
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
  command fzf "$@"
}

# =========================================================
# 8. AUTOSUGGESTIONS (LAZY)
# =========================================================
autoload -U add-zsh-hook

_load_autosuggest() {
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  add-zsh-hook -d precmd _load_autosuggest
}
add-zsh-hook precmd _load_autosuggest

# =========================================================
# 9. OPTIONAL TOOLCHAINS (NON-BLOCKING)
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
# 10. PERFORMANCE MODE (SAFE DEFAULT)
# =========================================================
unsetopt XTRACE

# =========================================================
# 11. Q POST BLOCK (KEEP BOTTOM)
# =========================================================
#[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] &&
#  builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

