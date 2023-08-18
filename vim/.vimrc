syntax on
"leader mapping (<Space>)
let mapleader=" "

"vi configuration
set exrc
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set relativenumber
set incsearch
set nohlsearch
set hidden
set noerrorbells
set nowrap
"set smartcase
set termguicolors
set noshowmode
" set buffers open
set hidden

"undo
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set scrolloff=8

set colorcolumn=120
set signcolumn=yes


"mappings


"mappings
"norm Q gq

" Number 5
nnoremap Y y$
" nnoremap Y yg_

" Number 4 : keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z
"nnoremap <C-J> :cnext<CR>zzzv

" Number 3: Undo break points
inoremap , ,<C-g>U
inoremap . .<C-g>U
inoremap [ [<C-g>U
inoremap ! !<C-g>U
inoremap ? ?<C-g>U

" Number 2 : Jumplist mutations
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Number 1: Moving text
"Mappings to move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-J> <esc>:m .+1<CR>
inoremap <C-l> <esc>:m .-2<CR>
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


" Number 7 : quotes around visual selection
  vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>
  vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
  vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>
  vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>
  vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>

  inoremap jk <esc>
  inoremap kj <esc>

"  - Go on top of a word you want to change
" - Press cn or cN
" - Type the new word you want to replace it with
" - Smash that dot '.' multiple times to change all the other occurrences of the word

" nnoremap cn *``cgn
" nnoremap cN *``cgN

" -- Add space bellow or above without leaving normal mode
nnoremap <silent> [<space>  :<c-u>put!=repeat([''],v:count)<bar>']+1<cr>
nnoremap <silent> ]<space>  :<c-u>put =repeat([''],v:count)<bar>'[-1<cr>

" Use simple ; instead of shift + :
nnoremap ; :
vnoremap ; :

" Use this instead of touching Esc key
inoremap jk <Esc>
inoremap kj <Esc>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

nnoremap <Left> :echo "Use the h key!"<CR>
nnoremap <Down> :echo "Use the j key!"<CR>
nnoremap <Up> :echo "Use the k key!"<CR>
nnoremap <Right> :echo "Use the l key!"<CR>




" edit command
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

"" Whitespaces and indentation
function! Preserve(command)
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	execute a:command
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction 
nnoremap <silent>_$ :call Preserve("%s/\\s\\+$//e")<CR>
nnoremap <silent>_= :call Preserve("normal gg=G")<CR>


" Save only when changes are made
    nnoremap <F10> :up<CR>

" Shows the changes made since last save
nnoremap <Leader>C :w !diff % -<CR>

" Copy and paste with system clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "_dP
vnoremap <C-c> "+y
inoremap <C-v> <C-r>+

set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

nnoremap gb :ls<CR>:b<Space>
nnoremap 0 ^
nnoremap ^ 0

nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

noremap x "_x
vnoremap p "_dP


colorscheme habamax

"mappings

"Mode Settings
if $TERM == "xterm-kitty"
    try
" Change the cursor in different modes
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[2 q" "EI = NORMAL mode (ELSE)

"Cursor settings:

"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
"
    catch
    endtry
endif

