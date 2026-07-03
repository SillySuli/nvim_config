-- (Lua config)

vim.g.mapleader = " "
-- vim.g.maplocalleader = ","  -- ( If you ever decide to use a more niche control over certain filetypes )

require("nconf.remap")
require("nconf.set")
-- require("nconf.lazy")


-- Attempt migrating to vim.pack

-- Place Auto command here if you have any later
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name = ev.data.spec.name
        local kind = ev.data.kind
        if kind ~= 'install' and kind ~= 'update' then return end

        if name == 'nvim-treesitter' then
            if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
            vim.cmd 'TSUpdate'
            return
        end
    end,
})


-- Helper function to reduce repetition
function gh(repo) return 'https://github.com/' .. repo end

-- Include Telescope
require('nconf.plugin.telescope')

-- Include colour Scheme
require('nconf.plugin.kanagawa')

-- Include mini and various plugins
require('nconf.plugin.mini')

-- Indclude todo comments
require('nconf.plugin.todo')

-- Include Lualine
require('nconf.plugin.lualine')

-- Include Treesitter
require('nconf.plugin.treesitter')

-- Include Fidget
require('nconf.plugin.fidget')

-- Include LSP

-- LSP DEF  -- [[ LSP Configuration ]]
  -- Brief aside: **What is LSP?**
  --
  -- LSP is an initialism you've probably heard, but might not understand what it is.
  --
  -- LSP stands for Language Server Protocol. It's a protocol that helps editors
  -- and language tooling communicate in a standardized fashion.
  --
  -- In general, you have a "server" which is some tool built to understand a particular
  -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  -- processes that communicate with some "client" - in this case, Neovim!
  --
  -- LSP provides Neovim with features like:
  --  - Go to definition
  --  - Find references
  --  - Autocompletion
  --  - Symbol Search
  --  - and more!
  --
  -- Thus, Language Servers are external tools that must be installed separately from
  -- Neovim. This is where `mason` and related plugins come into play.
  --
  -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
  -- and elegantly composed help section, `:help lsp-vs-treesitter`
  

