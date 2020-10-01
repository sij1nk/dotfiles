" plugins {{{
call plug#begin('~/.local/share/nvim/site/autoload')

" Plug 'morhetz/gruvbox'
Plug 'junegunn/seoul256.vim'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'

call plug#end()
" }}}

" set stuff {{{
set number relativenumber

" Copy indent from current line when starting a new line
set autoindent

" Smart autoindenting for programming
set smartindent
set wrap
set incsearch
set ignorecase

" Move .viminfo file to a reasonable location
set viminfo='1000,n~/.config/nvim.viminfo

" Where ins-completion gets its ideas from
set complete+=i,t

set modeline
set modelines=5

" Don't display -- MODE -- at the bottom
set noshowmode

" Search becomes case sensitive when uppercase chars are present
set smartcase
set splitbelow splitright
set history=500
set magic
set showmatch
set ruler
set hid
set scrolloff=3
set matchtime=1

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path=.*/**

" Display all matching files when we tab complete
set wildmenu
set wildmode=list:longest,full
set wildignore+=**/node_modules/**,**/.git/**,**/.idea/**

" Linebreak on 200 characters
set lbr
set tw=200

" Disable backups - most stuff is in VCS anyway
set nobackup
set nowb
set noswapfile

" Tab size
" TODO: Should be using smart something instead
set tabstop=4
set shiftwidth=4
set smarttab

" Autoread when file is changed from the outside
set autoread
autocmd FocusGained,BufEnter * checktime

" }}}

" Enable filetype plugins
filetype plugin on
filetype indent on
syntax enable

" netrw {{{
let g:netrw_banner=0
let g:netrw_preview=1
let g:netrw_liststyle=3
let g:netrw_winsize=80
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|s\s\)\zs\.\S\+'

" }}}

" themes {{{
colorscheme seoul256-light
colorscheme seoul256
let g:seoul256_background = 234
let g:seoul256_light_background = 256
let g:lightline = {
    \ 'colorscheme': 'seoul256'
	\ }

let theme = system('readlink -f ${XDG_CONFIG_HOME}/X11/current_theme | sed "s/^.*_//g"')
if theme == "light\n"
	set bg=light
	autocmd vimenter * highlight EndOfBuffer ctermfg=15
	highlight EndOfBuffer ctermfg=15
elseif theme == "dark\n"
	set bg=dark
	" autocmd vimenter * highlight Normal ctermbg=none
	" autocmd vimenter * highlight EndOfBuffer ctermfg=0
	" highlight Normal ctermbg=none
	" highlight EndOfBuffer ctermfg=0
endif

" }}}

" remaps {{{
let mapleader=","

" Big brain stuff from |ins-completion|
function! CleverTab()
	if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$'
		return "\<Tab>"
	else
		return "\<C-N>"
	endif
endfunction
inoremap <silent> <Tab> <C-R>=CleverTab()<CR>

" Non-emacs ins-completion keybinds
inoremap <CR> <C-R>=pumvisible() ? "\<lt>C-y>" : "\<lt>CR>"<CR>
inoremap <C-j> <C-R>=pumvisible() ? "\<lt>C-n>" : "\<lt>C-j>"<CR>
inoremap <C-k> <C-R>=pumvisible() ? "\<lt>C-p>" : "\<lt>C-j>"<CR>
inoremap <S-Tab> <C-R>=pumvisible() ? "\<lt>C-p>" : "\<lt>S-Tab>"<CR>
inoremap <silent> <Esc> <C-R>=pumvisible() ? "\<lt>C-e>" : "\<lt>Esc>"<CR>

vnoremap <C-c> "+y
nnoremap Q @@

" Increment number
noremap <C-i> <C-a>

" Substitute
nnoremap <leader>sg :%s//g<LEFT><LEFT>
nnoremap <leader>sc :%s//gc<LEFT><LEFT><LEFT>
xnoremap <leader>sg :s//g<LEFT><LEFT>
xnoremap <leader>sc :s//gc<LEFT><LEFT><LEFT>

" Remove search highlights
noremap  <leader>c <Cmd>noh<CR>

" Shortcut to vimrc
nnoremap <leader>vrc <Cmd>vsplit $MYVIMRC<CR>

" fzf
noremap <C-p> <Cmd>Files<CR>

" Quicker access to Ex commands
nnoremap ; :
xnoremap ; :

" Space jumps to end of line
nnoremap <Space> $
xnoremap <Space> $

" Sudo write
" Could use 'sponge' from moreutils for this
cnoremap w!! w !sudo tee > /dev/null %

" Select all
noremap <C-a> ggVG
noremap <C-v> "+P

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-q> <C-w><C-q>

" }}}

" abbrevs {{{
iab hbs #!/bin/sh
ab myvim $MYVIMRC

" }}}

" autocmds {{{

" Delete trailing whitespace and newlines on save
augroup TrailingWs
autocmd!
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
augroup END

" Reload sxhkd bindings after writing the file
augroup StuffReload
autocmd!
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

	" Reload xrdb and alacritty colors after writing the file
	autocmd BufWritePost *.Xresources !xrdb -merge $HOME/.config/X11/.Xresources && xres_alacritty

	" Source zshrc and zprofile after editing them
	" TODO: Does this actually work?
	autocmd BufWritePost .zprofile !source ${ZDOTDIR}/.zprofile
	autocmd BufWritePost .zshrc !source ${ZDOTDIR}/.zshrc
augroup END

augroup VimReload
autocmd!
	autocmd BufRead $MYVIMRC
				\ loadview |
				\ normal zM
	autocmd BufWritePre $MYVIMRC mkview
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" }}}

" vim: foldcolumn=2 foldmethod=marker
