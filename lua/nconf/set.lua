-- ( Vim Config in Lua)

-- Note there is a slight difference between vim.o and vim.opt. 
-- Key difference interface stype and capabilities.
-- vim.opt more Lua friendly offering an interface
-- convenient interacting with tables.

-- Choosing a Cursor
-- vim.opt.guicursor = ""

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


-- Diagnostic settings
vim.diagnostic.config{
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underlie = { sverity = { min = vim.diagnostic.severity.WARN }},

    virtural_text = true -- Test show up at the end of the line
}

-- ============================================================================
-- FLOATING TERMINAL
-- ============================================================================

-- terminal
local terminal_state = {
  buf = nil,
  win = nil,
  is_open = false
}

local function FloatingTerminal()
  -- If terminal is already open, close it (toggle behavior)
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
    return
  end

  -- Create buffer if it doesn't exist or is invalid
  if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
    terminal_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set buffer options for better terminal experience
    vim.bo[terminal_state.buf].bufhidden = 'hide'
  end

  -- Calculate window dimensions
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Create the floating window
  terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Set transparency for the floating window
  vim.wo[terminal_state.win].winblend = 0
  vim.wo[terminal_state.win].winhighlight = 'Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder'

  -- Define highlight groups for transparency
  vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
  vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none", })

  -- Start terminal if not already running
  local has_terminal = false
  local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
  for _, line in ipairs(lines) do
    if line ~= "" then
      has_terminal = true
      break
    end
  end

  if not has_terminal then
        local shell = os.getenv('SHELL')
        assert(shell, "SHELL environment variable is not set")
        vim.fn.jobstart(shell, {term = true})
  end

  terminal_state.is_open = true
  vim.cmd("startinsert")

  -- Set up auto-close on buffer leave 
  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = terminal_state.buf,
    callback = function()
      if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_close(terminal_state.win, false)
        terminal_state.is_open = false
      end
    end,
    once = true
  })
end

-- Function to explicitly close the terminal
local function CloseFloatingTerminal()
  if terminal_state.is_open and vim.api.nvim_win_is_valid(terminal_state.win) then
    vim.api.nvim_win_close(terminal_state.win, false)
    terminal_state.is_open = false
  end
end

-- Key mappings for floating terminal.
vim.keymap.set("n", "<leader>t", FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
vim.keymap.set("t", "<Esc>", CloseFloatingTerminal, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })

