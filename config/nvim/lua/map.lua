local function map(modes, lhs, rhs, opts)
    local default_opts = { noremap = true, silent = true }

    if opts then
	default_opts = vim.tbl_extend('force', default_opts, opts)
    end

    if modes:len() == 0 then 
	vim.api.nvim_set_keymap('', lhs, rhs, default_opts)
    end

    for mode in modes:gmatch"." do
	vim.api.nvim_set_keymap(mode, lhs, rhs, default_opts)
    end
end

local function unmap(modes, lhs)
    vim.keymap.del(modes, lhs)
end

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function pumCj()
    return vim.fn.pumvisible() == 1 and t'<C-n>' or t'<C-j>'
end

function pumCk()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<C-k>'
end

function pumSTab()
    return vim.fn.pumvisible() == 1 and t'<C-p>' or t'<S-Tab>'
end

function pumEnter()
    return vim.fn.pumvisible() == 1 and t'<C-y>' or t'<CR>'
end

function pumEsc()
    return vim.fn.pumvisible() == 1 and t'<C-e>' or t'<Esc>'
end

function changeKeyboardLayout(layout) 
    if layout == "qwerty" then
	map('n', 'h', '<Left>', { noremap = false})
	map('n', 'j', '<Down>', { noremap = false})
	map('n', 'k', '<Up>', { noremap = false})
	map('n', 'l', '<Right>', { noremap = false})

	map('n', 'n', 'n')
	map('n', 'i', 'i')
	map('n', 'e', 'e')
	map('n', 'm', 'm')

    elseif layout == "c-dh" then
	map('n', 'm', '<Left>', { noremap = false})
	map('n', 'n', '<Down>', { noremap = false})
	map('n', 'e', '<Up>', { noremap = false})
	map('n', 'i', '<Right>', { noremap = false})

	map('n', 'k', 'n')
	map('n', 'h', 'i')
	map('n', 'l', 'e')
	map('n', 'j', 'm')

	-- TODO: telescope
	-- TODO: nvim-tree
	-- TODO: other stuff
	-- TODO: other modes (visual, ex, etc.)
    else
	vim.notify("Layout '" .. layout .. "' is not recognized!",
	    vim.log.levels.ERROR)
	return
    end

    vim.notify("Changed keyboard layout to '" .. layout .. "'", vim.log.levels.INFO)
end


map('n', '<Space>', '<Nop>')
map('n', '<C-h>', '<Cmd>NvimTreeToggle<CR>')

-- select all
map('', '<C-a>', 'ggVG')

-- help
map('n', '<Leader>?', ':h <c-r><c-w><cr>')

-- substitute
map('n', '<Leader>sg', ':%s//g<Left><Left>', { silent = false })
map('n', '<Leader>sc', ':%s//gc<Left><Left>', { silent = false })
map('x', '<Leader>sg', ':s//g<Left><Left>', { silent = false })
map('x', '<Leader>sc', ':s//gc<Left><Left>', { silent = false })

map('n', '<Leader>q', '<Cmd>quit<CR>')
map('n', '<Leader>Q', '<Cmd>qall!<CR>')
map('n', '<Leader>w', '<Cmd>write<CR>')
map('n', '<Leader>W', '<Cmd>wall<CR>')
map('n', '<Leader>vs', '<Cmd>vs<CR>')
map('n', '<Leader>sp', '<Cmd>sp<CR>')

map('n', 'gm', '0')
map('n', 'gi', '$')

-- source vimrc
map('n', '<Leader>vrc', '<Cmd>source $MYVIMRC<CR>')

-- remove search highlighting
map('n', '<Leader>c', '<Cmd>noh<CR>')

-- close quickfix
map('n', '<Leader>z', '<Cmd>cclose<CR>')

map('n', 'Q', '@@')

-- copy into system clipboard
map('v', '<C-c>', '"+y')

-- FIXME: this might break delimiterMate
-- FIXME: ...also not sure if these do anything...
map('i', '<CR>', 'v:lua.pumEnter()', { silent = true, expr = true })
map('i', '<C-j>', 'v:lua.pumCj()', { silent = true, expr = true })
map('i', '<C-k>', 'v:lua.pumCk()', { silent = true, expr = true })
map('i', '<S-Tab>', 'v:lua.pumSTab()', { silent = true, expr = true })
map('i', '<Esc>', 'v:lua.pumEsc()', { silent = true, expr = true })

-- move up/down in history in cmd mode
map('c', '<C-j>', '<Down>', { silent = false })
map('c', '<C-k>', '<Up>', { silent = false })

-- sudo write; could also use `sponge` from moreutils for this
map('c', 'w!!', 'w !sudo tee > /dev/null %', { silent = false }) 

-- telescope find files
map('n', '<C-p>', '<Cmd>Telescope find_files<CR>')
map('n', '<C-g>', '<Cmd>Telescope live_grep<CR>')
map('n', '<Leader><C-g>', '<Cmd>Telescope grep_string<CR>')
map('n', '<Leader><C-m>', '<Cmd>Telescope man_pages<CR>')
map('n', '<Leader><C-o>', '<Cmd>Telescope colorscheme<CR>')
map('n', '<Leader><C-d>', '<Cmd>Telescope lsp_definitions<CR>')
map('n', '<Leader><C-f>', '<Cmd>Telescope commands<CR>')

-- LSP 
map('n', 'N', '<Cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gC', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<Leader>d', '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<Leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>')
map('n', 'g[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', 'g]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<M-CR>', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<Leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<Leader>t', '<Cmd>lua vim.lsp.buf.completion()<CR>')
