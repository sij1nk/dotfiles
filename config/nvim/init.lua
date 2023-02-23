require 'options'
require 'plugins'
require 'autocmd'
require 'utils'
require 'map'
require 'rename'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

local function collapse_all()
    require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
    -- open as vsplit on current node
    local action = "edit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
	require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
	lib.expand_or_collapse(node)

    else
	require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
    end

end

local function vsplit_preview()
    -- open as vsplit on current node
    local action = "vsplit"
    local node = lib.get_node_at_cursor()

    -- Just copy what's done normally with vsplit
    if node.link_to and not node.nodes then
	require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

    elseif node.nodes ~= nil then
	lib.expand_or_collapse(node)

    else
	require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

    end

    -- Finally refocus on tree if it was lost
    view.focus()
end

require("nvim-tree").setup {
    -- open_on_setup = true,
    hijack_unnamed_buffer_when_opening = true,
    update_focused_file = {
	enable = true
    },
    diagnostics = {
	enable = true
    },
    modified = {
	enable = true
    },
    renderer = {
	add_trailing = true,
	group_empty = true,
	highlight_opened_files = "name",
    },
    view = {
	width = {},
	mappings = {
	    custom_only = false,
	    list = {
		{ key = "l", action = "edit", action_cb = edit_or_open },
		{ key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
		{ key = "h", action = "close_node" },
		{ key = "H", action = "collapse_all", action_cb = collapse_all }
	    }
	}
    },
    actions = {
	open_file = {
	    quit_on_open = false,
	    window_picker = {
		chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	    }
	}
    }
}

require('nvim-autopairs').setup {}
require('colorizer').setup {}



telescope = require('telescope')
telescope.setup {
    defaults = {
    },
    pickers = {
    },
    extensions = {
	['ui-select'] = {
	    require('telescope.themes').get_dropdown {
		-- even more opts
	    }
	}
    },
}

telescope.load_extension("ui-select")

local function ts_disable_on_large_buffers(lang, bufnr)
    if #vim.api.nvim_buf_get_lines(bufnr, 0, -1, false) > 5000 then
	return true
    end
    return false
end

require('nvim-treesitter.configs').setup {
    autotag = {
	enable = true,
	disable = ts_disable_on_large_buffers
    },
    -- highlighting also slows things down a bit
    highlight = {
	enable = true,
	disable = ts_disable_on_large_buffers
    },
    -- these seems to cause a lot of slowdown when editing large files and I don't
    -- really use them anyway
    --    incremental_selection = {
    -- enable = true,
    -- keymaps = {
    --     init_selection = "gnn",
    --     node_incremental = "grn",
    --     scope_incremental = "grc",
    --     node_decremental = "grm",
    -- },
    --    },

    -- indent works on JSX but on large files it crawls to a halt
    indent = {
	enable = true,
	disable = ts_disable_on_large_buffers
    },
}

local function on_attach()
    vim.wo.signcolumn='yes:1'
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- this is supposed to disallow focusing into the diagnostics hover window
-- but I don't think it actually works
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
vim.lsp.handlers.hover, { focusable = false }
)

local lsp = require('lspconfig')

-- NOTE(rg): pyright gives a lot of false positives
-- lsp.pyright.setup {
--     on_attach = on_attach,
--     capabilities = capabilities
-- }

lsp.clangd.setup {}

lsp.tsserver.setup {}

-- TODO(rg): OmniSharp kinda turns the CPU into a volcano. It'd be nice to do something about this
-- local pid = vim.fn.getpid()
-- vim.g.OmniSharp_server_path = "/opt/omnisharp-roslyn-bundled/run"
-- local omnisharp_bin = "/opt/omnisharp-roslyn-bundled/run"
-- lsp.omnisharp.setup {
--     cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) };
--     on_attach = on_attach,
--     capabilities = capabilities
-- }

rust_tools = require('rust-tools')

local opts = {
    tools = {
	autoSetHints = true,
	inlay_hints = {
	    show_parameter_hints = false,
	    parameter_hints_prefix = "",
	    other_hints_prefix = "=> ",
	},
    },
    server = {
	on_attach = function(_, bufnr)
	    -- Hover actions
	    vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
	    -- Code action groups
	    vim.keymap.set("n", "M-CR", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
	end,
	capabilities = capabilities,
	settings = {
	    ['rust-analyzer'] = {
		checkOnSave = {
		    command = 'clippy'
		},
		procMacro = {
		    enable = true
		}
	    }
	},
    }
}

rust_tools.setup(opts)

require('rose-pine').setup {
    dark_variant = "main",
    dim_nc_background = true,

    groups = {
	background = 'surface',
	border = "muted"
    },

    highlight_groups = {
	NvimTreeNormal = { bg = 'base', fg = 'text' },
	CursorLine = { bg = "overlay" },
	StatusLine = { bg = "rose", fg = "base" },
	NvimTreeOpenedFile = { fg = "rose" },
    }
}


require('catppuccin').setup {
    integrations = {
	telescope = true,
	nvimtree = true
    }
}

local cmp = require('cmp')
cmp.setup {
    preselect = cmp.PreselectMode.None,
    --    completion = {
    -- autocomplete = true
    --    },
    snippet = {
	expand = function(args)
	    vim.fn["vsnip#anonymous"](args.body)
	end,
    },
    mapping = {
	-- TODO: tab should open completion menu when not open, and select next
	-- item when it is open
	['<Tab>'] = cmp.mapping.select_next_item(),
	['<S-Tab>'] = cmp.mapping.select_prev_item(),
	['<C-j>'] = cmp.mapping.select_next_item(),
	['<C-k>'] = cmp.mapping.select_prev_item(),
	['<C-u>'] = cmp.mapping.scroll_docs(-4),
	['<C-d>'] = cmp.mapping.scroll_docs(4),
	['<CR>'] = cmp.mapping.confirm {
	    behavior = cmp.ConfirmBehavior.Replace,
	    select = false,
	},
	-- Keep this unmapped! If it is mapped, you'll have to double tap escape to exit insert
	-- mode sometimes, instead of a single tap
	-- ['<Esc>'] = cmp.mapping.abort(),
    },
    sources = {
	{ name = 'nvim_lsp' },
	{ name = 'vsnip' },
	{ name = 'path' },
	{ name = 'buffer' },
    },
}

require 'colors'
