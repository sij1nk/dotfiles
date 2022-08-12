require 'options'
require 'plugins'
require 'colors'
require 'autocmd'
require 'utils'
require 'map'
require 'rename'

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

require('nvim-treesitter.configs').setup {
    -- highlighting also slows things down a bit
    highlight = {
	enable = true,
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
    },
}

local function on_attach()
    vim.wo.signcolumn='yes:1'
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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

local opts = {
    tools = {
	autoSetHints = true,
	hover_with_actions = true,
	inlay_hints = {
	    show_parameter_hints = false,
	    parameter_hints_prefix = "",
	    other_hints_prefix = "=> ",
	},
    },
    server = {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
	    ['rust-analyzer'] = {
		checkOnSave = {
		    command = 'clippy'
		},
		procMacro = {
		    enable = false
		}
	    }
	},
    }
}

require('rust-tools').setup(opts)
require('rust-tools.hover_actions').hover_actions()

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
	-- TODO: decide whether to keep word or not
	-- ['<Esc>'] = cmp.mapping.abort(),
    },
    sources = {
	{ name = 'nvim_lsp' },
	{ name = 'vsnip' },
	{ name = 'path' },
	{ name = 'buffer' },
    },
}
