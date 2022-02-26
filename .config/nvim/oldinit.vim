" Plugins {{{
call plug#begin('~/.local/share/nvim/site/autoload')

	Plug 'leafgarland/typescript-vim'   " Typescript editing
	Plug 'prettier/vim-prettier'        " 'Prettier' linter integration
	Plug 'cespare/vim-toml'             " Toml filetype
	Plug 'maxmellon/vim-jsx-pretty'     " jsx,tsx filetype
	Plug 'mattn/webapi-vim'             " For Rust playpen
	Plug 'tpope/vim-surround'           " Surround keybinds
	Plug 'tpope/vim-commentary'         " Commenting keybinds
	Plug 'Raimondi/delimitMate'         " Automatically close characters that come in pairs
	Plug 'AndrewRadev/splitjoin.vim'    " Switch between single-line and multi-line statements
	Plug 'junegunn/fzf.vim'             " 'Fzf' integration
	Plug 'itchyny/lightline.vim'        " Status line
	Plug 'junegunn/seoul256.vim'        " Color theme
	Plug 'junegunn/goyo.vim'            " Distraction-free mode
	Plug 'neovim/nvim-lspconfig'        " Common configurations for LSP
	Plug 'nvim-lua/lsp_extensions.nvim' " Extensions to built-in LSP
	Plug 'nvim-lua/completion-nvim'     " Autocompletion framework for built-in LSP
	Plug 'evanleck/vim-svelte', {'branch': 'main'}
	Plug 'editorconfig/editorconfig-vim'

call plug#end()
" }}}

" Basic settings {{{

	let delimitMate_expand_cr=2
	let delimitMate_expand_space=1

	let g:prettier#autoformat_config_present=1
	let g:prettier#exec_cmd_async=0
	let g:prettier#config#print_width=80
	let g:prettier#config#tab_width=4
	let g:prettier#config#use_tabs="false"

	let g:rustc_path="/usr/bin/rustc"
	let g:rustfmt_autosave=1
	let g:rust_fold=1

	let g:netrw_banner=0
	let g:netrw_preview=1
	let g:netrw_liststyle=3
	let g:netrw_winsize=80
	let g:netrw_list_hide=netrw_gitignore#Hide()
	let g:netrw_list_hide.=',\(^\|s\s\)\zs\.\S\+'

	let g:rust_clip_command='xclip -selection clipboard'

	let g:EditorConfig_verbose = 1
	let g:EditorConfig_max_line_indicator = "none"

	let g:vimsyn_embed = 'l'

" }}}

" LSP {{{

	" TODO: only print signcolumn when LSP is used
	set signcolumn=auto
	set updatetime=300 "ms no movement to trigger CursorHold
	autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc
	" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
	nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
	nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
	nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
	nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
	nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
	nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
	nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

	" TODO: extract lua code to .lua files
	" TODO: figure out why diagnostic extensions does not work
	" lua << EOF
	"     local nvim_lsp = require('lspconfig')
	"     local on_attach = function(client)
	" 	require('completion').on_attach(client)
	"     end

	"     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	" 	require('lsp_extensions.workspace.diagnostic').handler, {
	" 	    signs = {
	" 	      severity_limit = "Error",
	" 	    }
	" 	}
	"     )

	"     nvim_lsp.rust_analyzer.setup({ on_attach = on_attach })
" EOF

" }}}

" Colors {{{
colorscheme seoul256

let g:lightline = { 'colorscheme': 'lakeside_light' }

function! SetHighlights(highlights)
    for [key, value] in items(a:highlights)
	for args in items(value)
	    execute 'highlight ' . key . ' ' . args[0] . '=' . args[1]
	endfor
    endfor
endfunction

function! UpdateScheme()
    let highlights = {}
    let mode = substitute(system('cat ~/.config/X11/mode'), '\n\+$', '', '')
    let xrdb = split(system('xrdb -q | grep \*color\[0-9\] | sort -V | sed "s/^.*#/#/g"' ), "\n")
    if(len(xrdb) == 0)
	return
    endif
    if mode ==# "dark"
	let &bg="dark"
	let highlights['StatusLine'] = {"guibg": xrdb[9], "guifg": xrdb[9]}
	let highlights['StatusLineNC'] = {"guibg": xrdb[9], "guifg": xrdb[9]}
	let highlights['VertSplit'] = {"guifg": xrdb[9]}
	let highlights['EndOfBuffer'] = {"guifg": xrdb[9]}
	let g:lightline = { 'colorscheme': 'lakeside' }
    else
	let &bg="light"
	let highlights['StatusLine'] = {"guibg": xrdb[0], "guifg": xrdb[0]}
	let highlights['StatusLineNC'] = {"guibg": xrdb[0], "guifg": xrdb[0]}
	let highlights['VertSplit'] = {"guibg": xrdb[0]}
	let highlights['EndOfBuffer'] = {"guifg": xrdb[0]}
	let g:lightline = { 'colorscheme': 'lakeside_light' }
    endif

    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()

    let highlights['Normal'] = {"guibg": "NONE"}
    let highlights['LineNr'] = {"guibg": "NONE", "guifg": xrdb[7]}
    let highlights['Folded'] = {"guibg": "NONE", "guifg": xrdb[3]}
    let highlights['FoldColumn'] = {"guibg": "NONE", "guifg": xrdb[11]}
    let highlights['CursorLineNr'] = {"guibg": "NONE", "guifg": xrdb[2]}
    let highlights['CursorLine'] = {"guibg": "NONE"}
    let highlights['SignColumn'] = {"guibg": "NONE", "guifg": xrdb[2]}
    let highlights['LspDiagnosticsError'] = {"guibg": "NONE", "guifg": xrdb[15]}
    let highlights['LspDiagnosticsErrorSign'] = {"guibg": "NONE", "guifg": xrdb[15]}
    let highlights['LspDiagnosticsErrorFloating'] = {"guibg": "NONE", "guifg": xrdb[15]}
    let highlights['LspDiagnosticsWarning'] = {"guibg": "NONE", "guifg": xrdb[11]}
    let highlights['LspDiagnosticsWarningSign'] = {"guibg": "NONE", "guifg": xrdb[11]}
    let highlights['LspDiagnosticsWarningFloating'] = {"guibg": "NONE", "guifg": xrdb[11]}
    let highlights['LspDiagnosticsInformation'] = {"guibg": "NONE", "guifg": xrdb[13]}
    let highlights['LspDiagnosticsInformationSign'] = {"guibg": "NONE", "guifg": xrdb[13]}
    let highlights['LspDiagnosticsInformationFloating'] = {"guibg": "NONE", "guifg": xrdb[13]}
    let highlights['LspDiagnosticsHint'] = {"guibg": "NONE", "guifg": xrdb[5]}
    let highlights['LspDiagnosticsHintSign'] = {"guibg": "NONE", "guifg": xrdb[5]}
    let highlights['LspDiagnosticsHintFloating'] = {"guibg": "NONE", "guifg": xrdb[5]}
    let highlights['LspReferenceText'] = {"guibg": "NONE", "guifg": xrdb[6]}
    let highlights['LspReferenceRead'] = {"guibg": "NONE", "guifg": xrdb[6]}
    let highlights['LspReferenceWrite'] = {"guibg": "NONE", "guifg": xrdb[6]}

    call SetHighlights(highlights)
endfunction

call UpdateScheme()

" }}}

noremap  <leader>df <Cmd>Goyo<CR>
noremap  <leader>ndf <Cmd>Goyo!<CR>

" fzf
noremap <C-p> <Cmd>Files<CR>

" Autocmds {{{
function! <SID>StripTailingWhitespace()
    let l = line(".")
    let c = col(".")
    %s/\s+$//e
    call cursor(l, c)
endfun

autocmd FocusGained,BufEnter * checktime

" Delete trailing whitespace and newlines on save
augroup TrailingWhitespace
autocmd!
	autocmd BufWritePre * :call <SID>StripTailingWhitespace()  
augroup END

augroup Resize
autocmd!
    autocmd VimResized * :exe "norm! \<C-W>=\r"
augroup END

augroup Signals
autocmd!
    autocmd Signal * call UpdateScheme()
augroup END

" Reload sxhkd bindings after writing the file
augroup ReloadStuff
autocmd!
	autocmd BufWritePost $MYVIMRC ++nested source $MYVIMRC
	autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd
	autocmd BufWritePost *dunstrc.temp !xres_dunst
        autocmd BufWritePost *alacritty.yml.temp !xres_alacritty

	" Source zshrc and zprofile after editing them
	" TODO: Does this actually work?
	" autocmd BufWritePost .zprofile !source ${ZDOTDIR}/.zprofile
	" autocmd BufWritePost .zshrc !source ${ZDOTDIR}/.zshrc
augroup END

augroup FormatStuff
autocmd!
	autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.css,*.scss,*.sass,*.html,*.json,*.md PrettierAsync
augroup END

" TODO: document
augroup InlayHints
autocmd!
	" Enable type inlay hints
	autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
	\ lua require'lsp_extensions'.inlay_hints({
	\ prefix = ' » ',
	\ highlight = "NonText",
	\ enabled = {"TypeHint", "ChainingHint", "ParameterHint"} })
augroup END

" Lua: 2 tabwidth and use spaces
augroup LuaSvelte
autocmd!
	autocmd BufNewFile,BufRead *.lua,*.svelte
	\ set textwidth   =100 |
	\ set shiftwidth  =0 | 
	\ set tabstop     =2 |
	\ set expandtab 
augroup END

" Xml: 2 tabwidth with tabs
augroup XmlHtml
autocmd!
	autocmd BufNewFile,BufRead *.xml,*.html
	\ set textwidth  =0 |
	\ set shiftwidth =0 |
	\ set tabstop    =2 |
	\ set noexpandtab
augroup END

augroup Markdown
autocmd!
    autocmd FileType md,markdown nnoremap <buffer> <leader>l Ea)<Esc>Bi[](<Esc>hi
augroup END

" Sql: don't break lines
augroup Sql
autocmd!
	autocmd BufNewFile,BufRead *.sql
	\ set textwidth =0
augroup END

" Toc: treat as config file
augroup Toc
autocmd!
	autocmd BufNewFile,BufRead *.toc
	\ set filetype =config
augroup END

augroup ResizeWorkaround
autocmd!
	autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
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

