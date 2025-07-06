# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
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

export EDITOR=nvim
export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILE="${HOME}/.zsh_history"
export HISTCONTROL=ignorespace:ignoredups

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


# Enable vi mode
bindkey -v

#disk usage
alias du="du -hs . 2>/dev/null"
alias d=dust -T 8 -B
alias dir_size_git="fdu() {du -hsx .[^.]* |rg \$1}; fdu"
dir_size() {du -hsx $1}
#find folders with size greater than 1g
#alias f1g='du -sh .[^.]* * 2>/dev/null| rg "\dG"'
#find files by passing the size parameter , it displays the st_block size
alias f1='fdd() { find . -type f -size +$1 -exec ls -sh {} \; 2>/dev/null ;}; fdd'
#alias g='grep --color '
alias g="rg --colors 'match:fg:magenta' 2>/dev/null"
alias gr="rg --colors 'match:fg:magenta' 2>/dev/null"
#alias gri='grep --color -ir '

#hexdump
alias hx="hexdump -C"
#history
alias h="history 100|rg "
alias hv="history|nvim"


#alias ll="ls -al"
alias ls="lsd"
alias ll="lsd --long --sort time --reverse"
alias la="lsd -a --long --sort time --reverse"
alias l="ls -alFr"
#ldd -> otool
alias ldd="echo 'ldd->otool';otool -L"

#netstat
alias netstat="netstat -talWn"

#podman process list
alias pps="podman ps -s -a"
#podman image list
alias pil="podman image ls"
#podman container list
alias pcl="podman container ls -a"
#podman search
alias psi="podman search "
alias pitree="podman image tree "
#podman remove image
alias pri="podman rmi "
#podman remove container
alias prc="podman rm "
#podman system df
alias pdf="podman system df "
# remove unused data (stopped containers, stopped pods and dangling images)
alias pprune="podman system prune "
alias pins="podman inspect "
alias prunc="podman run -it  "

#python 
alias py="python3"
alias pyserver="python3 -m http.server 7777"

#alias cat="bat"
#stow
alias s="stow -v "
alias st="stat -f '%A %a %n'"

alias tree="lsd --tree"
alias tl='tldr'
alias t='top -s 10 -o mem -O cpu -U $USER'
# fzf
alias e="fd --type f --hidden --exclude .git|fzf -e|xargs nvim"
alias f="fd --type f --hidden --exclude .git|fzf -e --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down|xargs nvim"
alias v="fzf -e|xargs nvim"
alias fzf="fzf --tac --multi --reverse --cycle"

#leaks , alternative to valgrind
alias vg="leaks --atExit --"

alias vi="/opt/homebrew/bin/nvim -p "
alias vimdiff="/opt/homebrew/bin/nvim -d "
#exit terminal
alias x="exit"

#This would allow to move between words CMD <- or CMD -> on terminal
#bindkey -e
#bindkey '^[[1;9C' forward-word
#bindkey '^[[1;9D' backward-word

#alias v=~/.nix-profile/bin/vi
#alias vi=~/.nix-profile/bin/nvim
#fzf and vi
#vi -o `fzf -e`
export FZF_DEFAULT_COMMAND='fd --type f --exclude .git --exclude node_modules --strip-cwd-prefix --color=never --hidden .'
export FZF_DEFAULT_OPTS='--no-height --color=bg+:#343d46,gutter:-1,pointer:#ff3c3c,info:#0dbc79,hl:#0dbc79,hl+:#23d18b'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
export FZF_CTRL_T_OPTS="--preview 'cat {}'"

export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -50'"
export FZF_ALT_C_OPTS="--preview 'ls -ltrh {} | head -50'"
bindkey -s '^e' 'nvim $(fd --type f --color=never --hidden . |fzf)\n'

# fzf

alias dr='doom run '
#git alias
alias gaa='git add --all'
alias gau='git add --update'
alias gap='git add --patch' #similar to interactive
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
alias gho='git hash-object -w' #pass the file-name
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
alias gwl='git worktree list'
gwa(){git worktree add -b $1 "../$1" $2}
gwr() {git worktree remove $1}

#alias ff='find . -type f -path "*/.*"|fzf|pbcopy'
alias ff='fd -t f $1 |fzf|pbcopy'
alias dir='fd -t d |fzf|pbcopy'
#alias fi='vi $(find . -type f -path "*/.*"|fzf)'

#export SHELL=~/nix-profile/bin/zsh
# Add Visual Studio Code (code)
export PATH="/usr/local/bin/:/opt/homebrew/bin:$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$HOME/.config/emacs/bin:"

#fzf setup
set rtp+=/opt/homebrew/opt/fzf

eval "$(/opt/homebrew/bin/starship init zsh)"
#eval "$(/opt/homebrew/bin/zoxide init zsh)"
eval "$(/opt/homebrew/bin/zoxide init zsh)"


alias zq="zoxide query -ls"

se() {du -a . |awk '{print $2}'|fzf|xargs -or $EDITOR;}
vf() {fzf|xargs -or -I % $EDITOR %;}
cpvv() {cp -v "$1" "$(awk '{print $2}' ~/.config |rg -vi memes |fzf| sed "s|~|$HOME|")";}

#compile program
c() {clang -std=c2x -Wall -Wextra -pedantic $*}

#sed -> sd replacementChar filename
sd() {sed "s/\(.*\) \(.*\)/\1$1 \2/" $2}

#sed break the name in string
sdb() {sed "s/\(num\)\(.*r\)/\1->\2/" $2}

#tmux configuration
export TMUX=screen-256color
alias tx="tmux a -t dev || tmux new -t dev"

PATH=~/.cargo/bin:$PATH
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

eval "$(pyenv init -)"
export TERM=xterm-256color
#To use the bundled libc++ please add the following LDFLAGS:
#LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"PATH=~/.console-ninja/.bin:$PATH

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

complete -C '/usr/local/bin/aws_completer' aws

source <(fzf --zsh)

#source ~/dev/3rdParty/fzf-git.sh/fzf-git.sh

bindkey -v

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Q post block. Keep at the bottom of this file.
#[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] 
#&& builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

