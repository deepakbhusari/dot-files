#PROMPT = '%1~ %# '

export EDITOR=vi
#PROMPT=""
#PROMPT="%n-%D@%T:~ "
#PROMPT="[%D@%T %H:%M:%S}] %m-%h-:~ "
PROMPT="[$(date +%Y.%m.%d-%H:%M:%S)] %n %~/ :~ "

# K8s auto-complete
autoload -U +X compinit && compinit
source <(kubectl completion zsh)

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

alias f="fd --type f --hidden |fzf |xargs nvim"

#git alias
alias gs='git status'
alias gst='git status'
alias gaa='git add --all'
alias gl='git pull'
alias gp='git push'
alias gd='git diff | mate'
alias gau='git add --update'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcot='git checkout -t'
alias gcotb='git checkout --track -b'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias gld='git log --pretty=format:"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short --graph'
alias gls='git log --pretty=format:"%C(green)%h\\ %C(yellow)[%ad]%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'



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


