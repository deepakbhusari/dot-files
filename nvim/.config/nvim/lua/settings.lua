--This file holds all the vim configuration settings

--neovim lua config file
--vim.g.my_option = "my value" for setting global vim options.
-- vim.o.my_option = "my value" for setting other options.
-- vim.wo.my_option = "my value" for setting window-specific options.
-- vim.bo.my_option = "my value" for setting buffer-specific options.

--define variables for vim
local vimo = vim.o

--mappings functions in lua
local function map(kind, lhs, rhs, opts)
  vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
  -- example vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap=true})
end

local silentnoremap = { noremap = true, silent = true }

vim.scriptencoding = 'utf-8'

-- Map <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.loader.enable()

-- Editor options

vimo.number = true
-- o.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line.
vimo.clipboard = 'unnamedplus' -- uses the clipboard register for all operations except yank.
-- o.syntax = "on" -- When this option is set, the syntax with this name is loaded.
-- o.autoindent = true -- Copy indent from current line when starting a new line.
vimo.cursorline = true -- Highlight the screen line of the cursor with CursorLine.
vimo.expandtab = true -- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
vimo.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent.
vimo.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for.
vimo.encoding = 'utf-8' -- Sets the character encoding used inside Vim.
vimo.fileencoding = 'utf-8' -- Sets the character encoding for the file of this buffer.
vimo.ruler = true -- Show the line and column number of the cursor position, separated by a comma.
--vimo.mouse = "a" -- Enable the use of the mouse. "a" you can use on all modes
vimo.title = true -- When on, the title of the window will be set to the value of 'titlestring'
vimo.hidden = true -- When on a buffer becomes hidden when it is |abandon|ed
vimo.ttimeoutlen = 0 -- The time in milliseconds that is waited for a key code or mapped key sequence to complete.
vimo.wildmenu = true -- When 'wildmenu' is on, command-line completion operates in an enhanced mode.
vimo.showmatch = true -- When a bracket is inserted, briefly jump to the matching one.
vimo.showcmd = true -- Show (partial) command in the last line of the screen. Set this option off if your terminal is slow.
vimo.inccommand = 'split' -- When nonempty, shows the effects of :substitute, :smagic, :snomagic and user commands with the :command-preview flag as you type.
vimo.splitbelow = 'splitright' -- When on, splitting a window will put the new window below the current one

local options = {
  autoindent = true,
  numberwidth = 4,
  showtabline = 1,
  hlsearch = false,
  ignorecase = true,
  smartcase = true,
  undofile = true,
}
for option, value in pairs(options) do
  vimo[option] = value
end

vim.cmd [[

syntax on
"leader mapping (<Space>)
let mapleader=" "

"vi configuration
set exrc
set tabstop=2 softtabstop=2
set shiftwidth=2
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

"undo
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile

set scrolloff=8

set colorcolumn=120
set signcolumn=yes
"set column divider color to grey
highlight ColorColumn ctermbg=0 guibg=grey

"colorscheme torte
"colorscheme tokyonight

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

nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>

nnoremap gb :ls<CR>:b<Space>
nnoremap 0 ^
nnoremap ^ 0

nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

"colorscheme habamax

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

noremap x "_x
vnoremap p "_dP
set showtabline=2
autocmd FileType c,cpp setlocal equalprg=clang-format

"mappings

]]

-- Intuitive increment and decrement
-- This is for map function for neovim
map('n', '+', '<c-a>', silentnoremap)
map('n', '-', '<c-x>', silentnoremap)

-- Conveniently enter command mode
-- Don't use silent=true as this removes the command line.
map('n', ';', ':', { noremap = true })

-- Go to definition and pop back up
-- Don't do noremap to allow accessing LSP behaviour
map('n', '<right>', 'gd', { silent = true })
map('n', '<left>', '<c-t>', { silent = true })

--telescope mappings
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { silent = true })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { silent = true })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { silent = true })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { silent = true })

--terminal
map('n', '<leader><leader>', '<cmd>tabnew term://zsh<cr>A', { silent = true })

map('n', '<leader>rr', '<c-t><c-c><up><cr><c-t>', { silent = true })

--map(':tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
-- :tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
