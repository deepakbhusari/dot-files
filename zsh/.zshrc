#PROMPT = '%1~ %# '

export EDITOR=vi
#PROMPT=""
#PROMPT="%n-%D@%T:~ "
#PROMPT="[%D@%T %H:%M:%S}] %m-%h-:~ "
PROMPT="[$(date +%Y.%m.%d-%H:%M:%S)] %n %~/ :~ "

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# K8s auto-complete
#autoload -U +X compinit && compinit
#source <(kubectl completion zsh)

#source ~/./antigen.zsh

# Load Antigen configurations
#antigen init ~/.antigenrc

#fzf setup
set rtp+=/opt/homebrew/opt/fzf

# Enable vi mode
bindkey -v

#alias v=~/.nix-profile/bin/vi
#alias vi=~/.nix-profile/bin/nvim
alias vi="/opt/homebrew/bin/nvim -p "
#alias ll="ls -al"
alias tree="exa --tree"
alias ls="exa"
alias ll="exa -alhs modified"

#alias cat="bat"
#stow
alias s="stow -v "

# fzf
alias e="fd --type f --hidden |fzf |xargs nvim"
alias fzf="fzf --tac --multi --reverse --cycle"
export FZF_DEFAULT_COMMAND='fd --type f --color=never --hidden .'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
export FZF_CTRL_T_OPTS="--preview 'cat {}'"

export FZF_ALT_C_COMMAND='fd --type d . --color=never --hidden'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
bindkey -s '^e' 'nvim $(fd --type f --color=never --hidden . |fzf)\n'

# fzf

#history
alias h="history"
alias hv="history|nvim"

#git alias
alias gaa='git add --all'
alias gba='git branch -a'
alias ge='git clone --depth=1 '
alias gs='git status'
alias gsh='git show'
alias gu='git push'
alias gp='git pull'
alias gd='git diff | kdiff3'
alias gd='git diff'
alias gau='git add --update'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
alias gl='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias gld='git log --pretty=format:"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short --graph'
alias gls='git log --pretty=format:"%C(green)%h\\ %C(yellow)[%ad]%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'

alias ff='find . -type f -path "*/.*"|fzf|pbcopy'
#alias fi='vi $(find . -type f -path "*/.*"|fzf)'

#export SHELL=~/nix-profile/bin/zsh
# Add Visual Studio Code (code)
export PATH="$PATH:Applications/Visual Studio Code.app/Contents/Resources/app/bin"

eval "$(/opt/homebrew/bin/starship init zsh)"
eval "$(/opt/homebrew/bin/zoxide init zsh)"

se() {du -a . |awk '{print $2}'|fzf|xargs -or $EDITOR;}
vf() {fzf|xargs -or -I % $EDITOR %;}
c() {cp -v "$1" "$(awk '{print $2}' ~/.config |grep -vi memes |fzf| sed "s|~|$HOME|")";}

#tmux configuration
export TMUX=screen-256color
alias tm="tmux a -t dev || tmux new -t dev"

export PATH="/opt/homebrew/bin:$PATH"


# pnpm
export PNPM_HOME="~/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end



# bun completions
[ -s "/Users/manisha/.bun/_bun" ] && source "/Users/manisha/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
