-- ( Vim Config in Lua)

-- Note there is a slight difference between vim.o and vim.opt. 
-- Key difference interface stype and capabilities.
-- vim.opt more Lua friendly offering an interface
-- convenient interacting with tables.

-- Choosing a Cursor
vim.opt.guicursor = ""

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Indent setting, use help if confused
vim.opt.autoindent = true
vim.opt.smartindent = true 
vim.opt.smarttab = true

-- Adding little visual markers for things like whitespaces
vim.opt.list = true
vim.opt.listchars = "eol:.,tab:>-,trail:~,extends:>,precedes:<"

-- Side number setting
vim.opt.number = true
vim.opt.relativenumber = true

-- Highight cursor line
vim.opt.cursorline = true

-- Enable sign column
vim.opt.signcolumn = "yes:1"

-- Min 8 lines below and above
vim.opt.scrolloff = 8

-- Show partial commands are you type bottom right
vim.opt.showcmd = true

-- Relative column markers
vim.opt.textwidth = 80
vim.opt.colorcolumn = '+1'

-- ( Settings for backup, and swapfiles are auto enabled for now )
--[[
    Setting up undo directory, where persistent undo files are stored. 
    Letting you undo beyond current vim session
--]]
vim.opt.undodir = os.getenv("HOME") .. "/.vim//undodir" 
vim.opt.undofile = true -- ( Turn the undo presistence on )

-- Universal copy and paste, scheduled after `UiEnter` for faster start-up time
-- vim.schedule( function () vim.opt.clipboard = "unnamed" end ) 

-- Search Highlight setting
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Case setting
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Using 24 bit colours as long as termnail can handle it
vim.opt.termguicolors = true

-- if you ever decide that you do not want to see the mode on the bottom left
-- vim.opt.showmode = false

-- Mouse setting if you ever decide to use it.
-- vim.opt.mouse = "a"

-- Visually preserving indents when boken
vim.opt.breakindent = true

-- Update Swapfile 500 ms after nothing is typed
vim.opt.updatetime = 500

-- Decrease wait time for inbetween mapped sequence
vim.opt.timeoutlen = 500

-- Splitscreen configuration
vim.opt.splitbelow = true
vim.opt.splitright = true

 -- live preview of things like substitutions as you type live
vim.opt.inccommand = 'split'

-- Rounded border pop up windows
vim.opt.winborder = 'rounded'

 -- ( Disabling automatic comment insertions )
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
