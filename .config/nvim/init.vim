" general
let mapleader=" "
let &t_ut=''
syntax on
set number
set relativenumber
set cursorline
set wrap
set showcmd
set wildmenu
set encoding=utf-8
set mouse=a " enable mouse
set autochdir
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
set scrolloff=5

" set clipboard
" set clipboard=unnamedplus,unnamed

" set tab
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" set cursorshape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" set search
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase

" map keys to move
noremap J 5j
noremap K 5k
noremap H 7h
noremap L 7l

noremap <C-j> ^
noremap <C-k> $

noremap = nzz
noremap - Nzz
noremap <LEADER><CR> :nohlsearch<CR>

" map file opera 
map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>

" map split
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitbelow<CR>:split<CR>

map <LEADER>h <C-w>h
map <LEADER>l <C-w>l
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

map sv <C-w>K
map sh <C-w>L

" multi-tab
map tu :tabe<CR>

map tj :-tabnext<CR>
map tk :+tabnext<CR>

" most plugin require
set nocompatible 
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

" in case vim-plug not installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" add plug
call plug#begin('~/.vim/plugged')

" taskbar
Plug 'vim-airline/vim-airline'

" read and write without privi
Plug 'lambdalisue/suda.vim'

" better icon
Plug 'ryanoasis/vim-devicons'

" auto complete
" Plug 'ycm-core/YouCompleteMe'

" start screen
Plug 'mhinz/vim-startify'

" file navigate
Plug 'preservim/nerdtree'

" coc conquer of completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end() 


" nerdtree config
map tt :NERDTreeToggle<CR>

" suda.vim config
let g:suda_smart_edit = 1

" ===
" COC
" ===

let g:coc_global_extensions = ['coc-json','coc-vimlsp']

" set hidden

" faster
set updatetime=300

set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" set shortmess+=c
inoremap <silent><expr> <c-p> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> <LEADER>d :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasPrmvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)


" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
