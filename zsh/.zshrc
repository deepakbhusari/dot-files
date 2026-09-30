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
  $HOME/.config/emacs/bin
  /opt/homebrew/opt/llvm/bin
  /opt/homebrew/bin
  /usr/local/bin
  $HOME/.bun/bin
  $HOME/.local/bin
  $HOME/.console-ninja/.bin
  $path
)
export PATH

# =========================================================
# 3. BASIC ALIASES
# =========================================================
alias brew='arch -arm64 brew'

alias clr='clear'
alias cwd="pwd|pbcopy"


alias dus="du -hs . 2>/dev/null"
alias d="du -khd 1"
alias dust="dust -T 8 -B"

alias de="arch -arm64 ~/.config/emacs/bin/doom emacs"

alias fdd='fd -t d | fzf|pbcopy'
alias fdf='fd -t f | fzf|pbcopy'
alias fdh='fd -HI .| fzf|pbcopy'
#multiple files
alias fdm='fd .|fzf -m|pbcopy'
alias fdg='rg . -l|fzf --preview "cat {}"'

alias g="rg --colors 'match:fg:magenta' 2>/dev/null"
alias hx="hexdump -C"
alias h="cd ~"
alias hs="history 1000|rg"

alias ls="lsd"
alias ll="lsd --long --sort time --reverse"
alias la="lsd -a --long --sort time --reverse"

alias py="python3"
alias pyserver="python3 -m http.server 7777"

# git
alias gb="git branch"
alias gs="git status"
alias gsp="git status --porcelain"
alias gss="git status --short"
alias gc="git commit -v"
alias gp="git pull --rebase"
alias gu="git push"
alias gd="git diff"
alias gdw="git diff -w"
alias gl="git log --stat"
#alias glo="git log --oneline --graph --decorate --all"
alias glo="git log --color --graph --pretty=format:'%C(#dc322f)%h%C(#b58900)%d %C(#eee8d5)%s %C(#dc322f)| %C(#586f75)%cr %C(#dc322f)| %C(#586e75)%an%Creset' --abbrev-commit"
alias gls="glo --stat"

#process
alias pg="pgrep"

alias x="exit"

bl() { if [[ -n "$1" ]]; then
        brew list|rg $1
       else 
         brew list
       fi
     }
p() {ps aux|rg $1|rg -v "rg"}

# =========================================================
# 4. FUNCTIONS
# =========================================================

#fold files with specific width
fld() { fold -s -w "$1" "$2" > "$3" }

#directory size
dir_size() { du -hsx "$1" }

#find files with size that is passed to function
f1() { find . -type f -size +"$1" -exec ls -sh {} \; 2>/dev/null }

#c compiler
c() { clang -std=c2x -Wall -Wextra -pedantic "$@" }

sd() { sed "s/\(.*\) \(.*\)/\1$1 \2/" "$2" }

sdb() { sed "s/\(num\)\(.*r\)/\1->\2/" "$2" }

#function to copy file contents to clipboard
clip() { cat "$1" | pbcopy }

#function to show git commit message prefix
showgit_message_prefix () {
echo "build:
chore:
ci:
docs:
feat:
fix:
perf:
refactor:
revert:
style:
test:"
}

#function to reset to develop
dev_git_reset_create_new_branch() {

}

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
# Change cursor shape depending on mode
# =========================================================
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    # Command mode: steady block
    echo -ne '\e[2 q'
    #MODE_INDICATOR="(cmd)"
  else
    # Insert mode: blinking bar
    echo -ne '\e[6 q'
    #MODE_INDICATOR="(ins)"
  fi
  zle reset-prompt
}
zle -N zle-keymap-select

# Also set cursor shape on shell startup
function zle-line-init {
  zle -K viins
  echo -ne '\e[6 q'
  #MODE_INDICATOR="(ins)"
}
zle -N zle-line-init

# Ensure cursor resets on exit
function reset-cursor {
  echo -ne '\e[0 q'
}
precmd_functions+=(reset-cursor)

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

# Use fzf for directory navigation
function cd() {
  if [[ $# -gt 0 ]]; then
    builtin cd "$@"
  else
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf +m) && builtin cd "$dir"
  fi
}

# gpo: Push current branch to origin
gpo() {
    # Ensure we're inside a Git repository
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "❌ Not inside a Git repository."
        return 1
    fi

    # Get the current branch name
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)

    # Handle detached HEAD state
    if [[ -z "$branch" ]]; then
        echo "❌ Detached HEAD state — cannot determine branch."
        return 1
    fi

    echo "🚀 Pushing branch '$branch' to origin..."
    git push origin "$branch"
}

