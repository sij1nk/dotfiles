vim.o.number = true
vim.o.ruler = true

vim.o.wrap = true
vim.o.linebreak = true     
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.modeline = true
vim.o.showmode = false
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.writebackup = true
vim.o.backup = false
vim.o.swapfile = false
vim.o.autoread = true
vim.o.magic = true
vim.o.showmatch = true
vim.o.hidden = true
vim.o.cursorline = true
vim.o.termguicolors  = true

vim.o.scrolloff = 3
vim.o.scrolljump = 3
vim.o.matchtime = 1
vim.o.path = ".*/**,/usr/include"
vim.o.history = 1000
vim.o.textwidth = 99
vim.o.fillchars = "vert: ,eob: "
vim.o.updatetime = 300 -- ms to wait before firing CursorHold event
vim.o.mouse = "a"

vim.o.autoindent = true         -- copy indent from current line when starting new line
vim.o.smartindent = true        -- autoindent but smarter
vim.o.smarttab = true           -- respect shiftwidth
vim.o.expandtab = false         -- use spaces instead of tabs
vim.o.shiftwidth = 4            -- number of spaces to use when indenting
vim.o.tabstop = 8               -- number of spaces that a tab counts for
vim.o.softtabstop = 4 
-- TODO: copyindent?

vim.o.wildmenu = false
vim.o.wildmode = "list:longest,full"
vim.o.wildignore = "**/node_modules/**,**/.git/**,**/.idea/**,**/.vs/**"
-- vim.o.complete = vim.o.complete .. ",t"
-- menuone: display menu even if there's only one item
-- noinsert: do not insert text until a selection is made
-- noselect: force user to select
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.shortmess = vim.o.shortmess .. "c"

vim.g.mapleader = ","
