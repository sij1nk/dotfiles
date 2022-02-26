return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use {
	'nvim-telescope/telescope.nvim',
	requires = { 
	    {'nvim-lua/plenary.nvim'},
	    {'nvim-treesitter/nvim-treesitter'},
	    {'kyazdani42/nvim-web-devicons'},
	    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
	}
    }

    use 'windwp/nvim-autopairs'
    use {
	'numToStr/Comment.nvim',
	config = function()
	    require('Comment').setup()
	end
    }

    use 'rust-lang/rust.vim';
    -- use 'OmniSharp/omnisharp-vim';

    -- colors
    use 'norcalli/nvim-colorizer.lua';
    use 'savq/melange'; -- default
    use 'jaredgorski/fogbell.vim'; -- black/white
    use 'AlessandroYorba/alduin'; -- dark, rustic
    use 'bluz71/vim-nightfly-guicolors'; 
    use 'kyazdani42/blue-moon';
    use 'sainnhe/everforest'; -- green
    use 'sainnhe/sonokai';
    use 'EdenEast/nightfox.nvim';

    use 'neovim/nvim-lspconfig';
    use 'simrat39/rust-tools.nvim';
    use 'hrsh7th/nvim-cmp'; -- Completion framework
    use 'hrsh7th/cmp-nvim-lsp'; -- LSP completion source
    use 'hrsh7th/cmp-vsnip'; -- snippet completion source
    use 'hrsh7th/cmp-path';
    use 'hrsh7th/cmp-buffer';
    use 'hrsh7th/vim-vsnip'; -- Snippet engine

    use 'nvim-telescope/telescope-ui-select.nvim';

end)
