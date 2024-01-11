#PROMPT = '%1~ %# '


#This is to capture zsh shell performance
#zmodload zsh/datetime
#setopt PROMPT_SUBST
#PS4='+$EPOCHREALTIME %N:%i> '

#logfile=$(mktemp zsh_profile.XXXXXXXX)
#echo "Logging to $logfile"
#exec 3>&2 2>$logfile

#setopt XTRACE

#To measure current zsh config performznce
#time zsh -i -c echo
#This is to capture zsh shell performance

export EDITOR=vi
#PROMPT="%n-%D@%T:~ "
#PROMPT="[%D@%T %H:%M:%S}] %m-%h-:~ "
#PROMPT="[$(date +%Y.%m.%d-%H:%M:%S)] %n %~/ :~ "

#if type brew &>/dev/null
#then
#  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

#  autoload -Uz compinit
#  compinit
#fi

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
alias vimdiff="/opt/homebrew/bin/nvim -d "
#alias ll="ls -al"
alias tree="lsd --tree"
alias ls="lsd"
alias ll="lsd --long --sort time --reverse"

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
alias gau='git add --update'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gca='git commit -v -am'
alias gcf='git cat-file blob' #pass the hash object
alias gct='git cat-file -t'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
# alias gd='git diff | kdiff3'
alias gd='git diff'
alias ge='git clone'
alias ge1='git clone --depth=1'
alias gh='git hash-object -w' #pass the file-name
alias gl='git log --pretty=format:"%C(yellow)%H%Cred%d\\ %C(green)%ad%Cred\\%Creset%s%Cblue\\ [%cn]" --decorate --date=format:"%Y-%m-%d %H:%M:%S %z" --numstat'
alias gld='git log --pretty=format:"%C(yellow)%H\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=format:"%Y-%m-%d %H:%M:%S %z" --graph'
alias glf='git log --pretty=format:"%C(yellow)%H\\ %C(green)%ad%Cred\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=format:"%Y-%m-%d %H:%M:%S %z" --graph -- '
alias glp='git log --pretty=format:"%C(yellow)%H%Cred%d\\ %C(green)%ad%Cred\\%Creset%s%Cblue\\ [%cn]" --decorate --date=format:"%Y-%m-%d %H:%M:%S %z" --numstat -p'
alias glr='git log --pretty=format:"%C(green)%H\\ %C(yellow)[%ad]%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'
alias glt='git ls-tree' #pass the hash-object
alias gp='git pull'
alias gs='git status'
alias gsh='git show'
alias gu='git push'

alias ff='find . -type f -path "*/.*"|fzf|pbcopy'
#alias fi='vi $(find . -type f -path "*/.*"|fzf)'

#export SHELL=~/nix-profile/bin/zsh
# Add Visual Studio Code (code)
export PATH="$PATH:Applications/Visual Studio Code.app/Contents/Resources/app/bin"

eval "$(/opt/homebrew/bin/starship init zsh)"
#eval "$(/opt/homebrew/bin/zoxide init zsh)"
eval "$(/opt/homebrew/bin/zoxide init zsh)"

se() {du -a . |awk '{print $2}'|fzf|xargs -or $EDITOR;}
vf() {fzf|xargs -or -I % $EDITOR %;}
c() {cp -v "$1" "$(awk '{print $2}' ~/.config |grep -vi memes |fzf| sed "s|~|$HOME|")";}

#tmux configuration
export TMUX=screen-256color
alias t="tmux a -t dev || tmux new -t dev"

export PATH="/opt/homebrew/bin:$PATH"


# pnpm
export PNPM_HOME="~/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end



# bun completions
#[ -s "/Users/manisha/.bun/_bun" ] && source "/Users/manisha/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

#This is to capture zsh shell performance
unsetopt XTRACE
#exec 2>&3 3>&-
#This is to capture zsh shell performance

export PATH="/opt/homebrew/opt/jpeg/bin:$PATH"
