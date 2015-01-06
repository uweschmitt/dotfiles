" https://github.com/sontek/dotfiles/
" ==========================================================
" Dependencies - Libraries/Applications outside of vim
" ==========================================================
" Pep8 - http://pypi.python.org/pypi/pep8
" Pyflakes
" Ack
" Rake & Ruby for command-t
" nose, django-nose

" ==========================================================
" Plugins included
" ==========================================================
" Pathogen
"     Better Management of VIM plugins
"
" GunDo
"     Visual Undo in vim with diff's to check the differences
"
" Pytest
"     Runs your Python tests in Vim.
"
" Commant-T
"     Allows easy search and opening of files within a given path
"
" Snipmate
"     Configurable snippets to avoid re-typing common comands
"     Underlines and displays errors with Python on-the-fly
"
" Fugitive
"    Interface with git from vim
"
" Git
"    Syntax highlighting for git config files
"
" Pydoc
"    Opens up pydoc within vim
"
" Surround
"    Allows you to surround text with open/close tags
"
" Py.test
"    Run py.test test's from within vim
"
" MakeGreen
"    Generic test runner that works with nose
"
" ==========================================================
" Shortcuts
" ==========================================================
set nocompatible              " Don't be compatible with vi
let mapleader=","             " change the leader to be a comma vs slash

" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

"fu! SplitScroll()
    ":wincmd v
    ":wincmd w
    "execute "normal! \<C-d>"
    ":set scrollbind
    ":wincmd w
    ":set scrollbind
"endfu

"nmap <leader>sb :call SplitScroll()<CR>


"<CR><C-w>l<C-f>:set scrollbind<CR>

" sudo write this
cmap W! w !sudo tee % >/dev/null

" Toggle the tasklist
map <leader>td <Plug>TaskList

map <leader>w :w<CR>

" Run pep8
let g:pep8_map='<leader>8'

" run py.test's
nmap <silent><Leader>tf <Esc>:Pytest file verbose<CR>
nmap <silent><Leader>tc <Esc>:Pytest class verbose<CR>
nmap <silent><Leader>tm <Esc>:Pytest method verbose<CR>
nmap <silent><Leader>tn <Esc>:Pytest next verbose<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous verbose<CR>
nmap <silent><Leader>te <Esc>:Pytest error verbose<CR>

" Run django tests
"map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>

" Reload Vimrc
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" open/close the quickfix window
nmap <leader>c :copen<CR>
nmap <leader>cc :cclose<CR>
nmap <leader>c1 :cc 1<CR>
nmap <leader>cn :cnext<CR>
nmap <leader>cp :cprev<CR>

" for when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

" ctrl-jklm  changes to that split
" map <c-j> <c-w>j
" map <c-k> <c-w>k
" map <c-l> <c-w>l
" map <c-h> <c-w>h

" and lets make these all work in insert mode too ( <C-O> makes next cmd
"  happen as if in command mode )
imap <C-W> <C-O><C-W>

" Open NerdTree
map <leader>n :NERDTreeToggle<CR>

" Run command-t file search
"map <leader>f :CommandT<CR>
" Ack searching
"
nmap <leader>a <Esc>:Ack!

" Load the Gundo window
map <leader>g :GundoToggle<CR>

" Jump to the definition of whatever the cursor is on
"map <leader>j :RopeGotoDefinition<CR>

" Rename whatever the cursor is on (including references to it)
"map <leader>r :RopeRename<CR>
" ==========================================================
" Pathogen - Allows us to organize our vim plugins
" ==========================================================
" Load pathogen with docs for all plugins
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" ==========================================================
" Basic Settings
" ==========================================================
syntax on                     " syntax highlighing
filetype on                   " try to detect filetypes
filetype plugin indent on     " enable loading indent file for filetype
set number                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=light           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.

" don't bell or blink
"set noerrorbells
"set vb t_vb=

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

set grepprg=ack         " replace the default grep program with ack


" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>


" Disable the colorcolumn when switching modes.  Make sure this is the
" first autocmd for the filetype here
"autocmd FileType * setlocal colorcolumn=0

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
set pumheight=6             " Keep a small completion window


""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldmethod=manual       " allow us to fold on indents
set foldlevel=2             " don't fold by default

" don't outdent hashes
" inoremap # #

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
"set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,trail:-,precedes:<,extends:>
set list

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Display
if has("gui_running")
    " let g:solarized_termtrans=1
    " let g:solarized_termcolors=256
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
    colorscheme solarized
    " Remove menu bar
    " set guioptions-=m

    " Remove toolbar
    set guioptions-=T
    set guifont=Source\ Code\ Pro\ 9
else
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
    let g:solarized_termtrans = 1
    colorscheme solarized
    set t_Co=16
endif

" Paste from clipboard
map <leader>p "+p
map <leader>P "+P

" yank to clipboard
nnoremap <leader>y "+y
nnoremap <leader>Y "+y


" Quit window on <leader>q
nnoremap <leader>q :q<CR>
nnoremap <leader>qq :qall<CR>

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>

" Select the item in the list with enter
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Javascript
" ==========================================================
" ==========================================================
" au BufRead *.js set makeprg=jslint\ %

" Use tab to scroll through autocomplete menus
"autocmd VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
"autocmd VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"

" let g:acp_completeoptPreview=1

" ===========================================================
" FileType specific changes
" ============================================================
" Mako/HTML
" autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
" autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" Python
"au BufRead *.py compiler nose
au FileType python set omnifunc=pythoncomplete#Complete complete=.,w,t,b,u      " no include !
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" au FileType python map <buffer> <F3> :call Flake8()<CR>
" au BufWritePost *.py call Flake8()
"
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1
nnoremap <silent> <f9> :TlistToggle<CR>


" let g:flake8_max_line_length=99

" au FileType coffee setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" Don't let pyflakes use the quickfix window
" let g:pyflakes_use_quickfix = 0
"
let g:PyFlakeCheckers = 'pep8,mccabe,frosted'
let g:PyFlakeMaxLineLength = 100

" vundle
"
"
"
set rtp+=~/.vim/bundle/vundle
call vundle#rc()


" Bundle 'wakatime/vim-wakatime'
" Bundle 'zhaocai/Goldenview.vim'
" Bundle 'andviro/flake8-vim'

" au BufEnter * EnableGoldenViewAutoResize

" close quickfix if it is the last window
au BufEnter * call MyLastWindow()


function! MyLastWindow()
    if &buftype=="quickfix"
        if winbufnr(2) == -1
            quit!
        endif
    endif
endfunction

function! CloseQuickFix()
    if &buftype!="quickfix"
        cclose
    endif
endfunction

map <C-y> <Esc>:'<,'>!cat \| tee /tmp/vimbuff<CR>
map <C-p> o<ESC>:.!cat /tmp/vimbuff<CR>



" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif

set colorcolumn=99


if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  autocmd BufRead,BufNewFile,FileReadPost *.py source ~/.vim/python.vim
endif

" This beauty remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

nnoremap <space> za
vnoremap <space> zf
" move selected lines
vmap K :m-2<CR>gv
vmap J :m'>+<CR>gv


let g:ackprg="ack-grep -H --nocolor --nogroup --column"

vmap <C-x> :!pbcopy<CR>  
vmap <C-c> :w !pbcopy<CR><CR> 
" you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

nnoremap <space> za
vnoremap <space> zf
" move selected lines
vmap K :m-2<CR>gv
vmap J :m'>+<CR>gv


let g:ackprg="ack-grep -H --nocolor --nogroup --column"

vmap <C-x> :!pbcopy<CR>  
vmap <C-c> :w !pbcopy<CR><CR> 
