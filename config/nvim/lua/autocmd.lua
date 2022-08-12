local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
	vim.api.nvim_command('augroup ' .. group_name)
	vim.api.nvim_command('autocmd!')
	for _, def in ipairs(definition) do
	    local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
	    vim.api.nvim_command(command)
	end
	vim.api.nvim_command('augroup END')
    end
end

-- function update_background()
--     conf_dir = os.getenv('XDG_CONFIG_HOME')
--     mode_file = conf_dir .. '/X11/mode'
--     mode = io.open(mode_file):read()
--
--     vim.o.background = mode
-- end

local autocmds = {
    -- fix splits when window is resized
    VimWindowResize = {
	{"VimResized", "*", [[:exe "norm! \<C-W>=\r"]]};
    };
    -- pretty sure this is for when vim refuses to take up all the vertical
    -- space when opened in a vertical split and acts all weirdly
    VimWindowResizeInitial = {
	{"VimEnter", "*", [[:silent exec "!kill -s SIGWINCH $PPID"]]};
    };
    PackerAutoCompile = {
	{"BufWritePost", "plugins.lua", [[source <afile> | PackerCompile]]};
    };
    ColorschemeAutoReload = {
	{"BufWritePost", "colors.lua", [[source <afile>]]};
    };
 --    SchemeUpdate = {
	-- {"Signal", "*", [[lua update_background()]]}
 --    };
    LSPShowLineDiagnostics = {
	{"CursorHold", "*", [[lua vim.diagnostic.open_float({focus = false})]]}
    };
    JSFormatting = {
	{"BufWritePre", "*.js,*.jsx,*ts,*tsx", "Neoformat"}
    };
    CSharpFormatting = {
	{"FileType", "cs", [[lua vim.o.expandtab = true]]}
	-- {"FileType", "cs", [[nmap <buffer> = <Plug>(omnisharp_code_format)]]}
    };
    EasierTerminalClose = {
	{"TermOpen", "*", [[if &buftype ==# 'terminal' | nnoremap <buffer>q :q<CR> | endif]]}
    };
}

nvim_create_augroups(autocmds)
