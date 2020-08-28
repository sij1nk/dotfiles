" Plugins
call plug#begin('~/.local/share/nvim/site/autoload')

Plug 'morhetz/gruvbox'

call plug#end()

set number relativenumber
set autoindent
set smartindent
set wrap
set incsearch
set splitbelow splitright
set history=500
set magic
set showmatch
set ruler
set hid
set so=3

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" Linebreak on 200 characters
set lbr
set tw=200

" Disable backups - most stuff is in VCS anyway
set nobackup
set nowb
set noswapfile

" Enable filetype plugins
filetype plugin on
filetype indent on
syntax enable

" Autoread when file is changed from the outside
set autoread
autocmd FocusGained,BufEnter * checktime

autocmd vimenter * colorscheme gruvbox

" Light or dark theme
let theme = system('readlink -f ${XDG_CONFIG_HOME}/X11/current_theme | sed "s/^.*_//g"')
if theme == "light\n"
	set bg=light
	autocmd vimenter * highlight EndOfBuffer ctermfg=15
elseif theme == "dark\n"
	autocmd vimenter * highlight Normal ctermbg=none
	autocmd vimenter * highlight EndOfBuffer ctermfg=0
endif


" Tab size
" TODO: Should be using smarttabs instead
set tabstop=4
set shiftwidth=4

" Basic remaps
vnoremap <C-c> "+y
noremap <C-v> "+P
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Delete trailing whitespace and newlines on save
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" Reload sxhkd bindings after writing the file
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Reload xrdb and alacritty colors after writing the file
autocmd BufWritePost *.Xresources !xrdb -merge $HOME/.config/X11/.Xresources && xres_alacritty

" Source zshrc and zprofile after editing them
autocmd BufWritePost .zprofile !source ${ZDOTDIR}/.zprofile
autocmd BufWritePost .zshrc !source ${ZDOTDIR}/.zshrc

" Reload vim after editing vimrc
" TODO: it should not set bg to opaque on dark theme
" autocmd BufWritePost *.vim source ${XDG_CONFIG_HOME}/nvim/init.vim
