" Plugins {{{
call plug#begin('~/.local/share/nvim/site/autoload')

	Plug 'rust-lang/rust.vim'           " Rust editing
	Plug 'leafgarland/typescript-vim'   " Typescript editing
	Plug 'peitalin/vim-jsx-typescript'  " JSX/TSX editing
	Plug 'prettier/vim-prettier'        " 'Prettier' linter integration
	Plug 'tpope/vim-surround'           " Surround keybinds
	Plug 'tpope/vim-commentary'         " Commenting keybinds
	Plug 'Raimondi/delimitMate'         " Automatically close characters that come in pairs
	Plug 'AndrewRadev/splitjoin.vim'    " Switch between single-line and multi-line statements
	Plug 'junegunn/fzf.vim'             " 'Fzf' integration
	Plug 'itchyny/lightline.vim'        " Status line
	Plug 'junegunn/seoul256.vim'        " Color theme
	Plug 'junegunn/goyo.vim'            " Distraction-free mode

call plug#end()
" }}}

" Settings {{{

	set number         " Display line numbers
	set ruler          " Display line and column number
	set wrap           " Wrap lines longer that exceed the textwidth or window width
	set linebreak      " Try not to break up words when wrapping if possible
	set autoindent     " Copy indent from current line when starting new line
	set smartindent    " Handle indent size changes correctly
	set smarttab       " Respect shiftwidth when entering tab in front of a line
	set incsearch      " Show matches while typing search string
	set ignorecase     " Ignore case in search patterns
	set smartcase      " Search becomes case sensitive when uppercase chars are present
	set modeline       " Read modelines
	set noshowmode     " Don't display -- MODE -- at the bottom
	set splitbelow     " Prefer putting new splits below current one
	set splitright     " Prefer putting new splits right to the current one
	set writebackup    " Make backups when overwriting files...
	set nobackup       " ...but remove them after the files were successfully written
	set noswapfile     " No lame swapfiles
	set autoread       " Auto read when file is changed from the outside
	set magic          " Handle special characters in search patterns in a sane way
	set showmatch      " Highlight matching bracket when inserting bracket
	set hidden         " Keep buffers loaded when they're abandoned
	set wildmenu       " Enhanced command-line completion

	set complete   +=i,t    " Where ins-completion gets its ideas from
	set scrolloff   =3      " Keep this many lines above/below cursor when scrolling
	set matchtime   =1      " Show matching brackets for {n}/10s of a second"
	set path        =.*/**,/usr/include " Search down into subfolders and header files
	set viminfo     ='1000,n~/.config/nvim.viminfo " Move .viminfo file to a reasonable location
	set history     =1000   " History of : commands and search patterns
	set textwidth   =80     " Wrap lines longer than {n}
	set shiftwidth  =4      " Indent size
	set softtabstop =4      " Number of spaces that a tab counts for
	set wildmode    =list:longest,full             " Determines what the cmd-line completion key does
	set wildignore +=**/node_modules/**,**/.git/**,**/.idea/** " Paths cmd-line completion should ignore

	let delimitMate_expand_cr=2
	let delimitMate_expand_space=1

	let g:prettier#exec_cmd_path="/usr/bin/prettier"
	let g:prettier#exec_cmd_async=1

	let g:rustfmt_autosave=1

	let g:netrw_banner=0
	let g:netrw_preview=1
	let g:netrw_liststyle=3
	let g:netrw_winsize=80
	let g:netrw_list_hide=netrw_gitignore#Hide()
	let g:netrw_list_hide.=',\(^\|s\s\)\zs\.\S\+'

" }}}

" Themes {{{
" set bg=light
colorscheme seoul256

" TODO: finish this
highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr ctermbg=NONE ctermfg=3
highlight Folded ctermbg=NONE ctermfg=3
highlight FoldColumn ctermbg=NONE ctermfg=3
highlight EndOfBuffer ctermfg=NONE
highlight CursorLineNr ctermbg=NONE ctermfg=2
highlight CursorLine ctermbg=NONE
let g:lightline = { 'colorscheme': 'ayu_light' }

" }}}

" Remaps {{{
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

" This line breaks delimitMate CR expansion
" inoremap <silent> <CR> <C-R>=pumvisible() ? "\<lt>C-y>" : "\<lt>CR>"<CR>
inoremap <C-j> <C-R>=pumvisible() ? "\<lt>C-n>" : "\<lt>C-j>"<CR>
inoremap <C-k> <C-R>=pumvisible() ? "\<lt>C-p>" : "\<lt>C-j>"<CR>
inoremap <S-Tab> <C-R>=pumvisible() ? "\<lt>C-p>" : "\<lt>S-Tab>"<CR>
inoremap <silent> <Esc> <C-R>=pumvisible() ? "\<lt>C-e>" : "\<lt>Esc>"<CR>

vnoremap <C-c> "+y
nnoremap Q @@

" Substitute
nnoremap <leader>sg :%s//g<LEFT><LEFT>
nnoremap <leader>sc :%s//gc<LEFT><LEFT><LEFT>
xnoremap <leader>sg :s//g<LEFT><LEFT>
xnoremap <leader>sc :s//gc<LEFT><LEFT><LEFT>
noremap  <leader>df <Cmd>Goyo<CR>
noremap  <leader>ndf <Cmd>Goyo!<CR>

" Remove search highlights
noremap  <leader>c <Cmd>noh<CR>

" Source vimrc
nnoremap <leader>src <Cmd>source $MYVIMRC<CR>

" fzf
noremap <C-p> <Cmd>Files<CR>

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

nnoremap <BS> :edit .<CR>

" }}}

" Abbrevs {{{
" }}}

" Autocmds {{{
autocmd FocusGained,BufEnter * checktime

" Delete trailing whitespace and newlines on save
augroup TrailingWs
autocmd!
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
augroup END

" Reload sxhkd bindings after writing the file
augroup ReloadStuff
autocmd!
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
	autocmd BufWritePost *dunstrc !killall dunst;notify-send "Reloaded dunst"

	" Reload xrdb and alacritty colors after writing the file
	autocmd BufWritePost *.Xresources !xrdb -merge $HOME/.config/X11/.Xresources && xres_alacritty

	" Source zshrc and zprofile after editing them
	" TODO: Does this actually work?
	" autocmd BufWritePost .zprofile !source ${ZDOTDIR}/.zprofile
	" autocmd BufWritePost .zshrc !source ${ZDOTDIR}/.zshrc
augroup END

augroup FormatStuff
autocmd!
	autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.sass,*.html PrettierAsync
	autocmd BufNewFile,BufRead *.c,*.cpp set equalprg=astyle
augroup END

augroup ReloadVimrc
autocmd!
	autocmd BufWritePost $MYVIMRC ++nested source $MYVIMRC
augroup END



" }}}

" Sessions {{{
	let session_dir='~/.config/nvim'

	augroup TypelongerSession
	autocmd!
		autocmd VimLeave ~/Repos/typelonger/**/* execute 'mksession! ' . session_dir . '/typelonger.vim'
		autocmd VimEnter ~/Repos/typelonger ++nested execute 'source ' . session_dir . '/typelonger.vim'
	augroup END

" }}}

" vim: foldcolumn=2 foldmethod=marker
