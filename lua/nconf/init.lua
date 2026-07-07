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

        -- Treesitter autocmd that get run to keep installed parsers up to date.
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
  
-- Include Fidget
-- Useful status updates for LSP on bottom right window
require('nconf.plugin.fidget')

-- Function that gets run when an LSP attaches itself to a current buffer
-- and configure LSP.
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', {clear = true}),
    callback = function(event)


    local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(
            mode,
            keys,
            func,
            {buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Active Buffer keybinds
    -- Rename the variable under your cursor
    map('grn', vim.lsp.buf.rename, '[G]o [R]e[n]ame')

    -- Execute code action, usually your
    -- Cursor need to be on top of a error or suggestions from LSP to activate
    map('gta', vim.lsp.buf.code_action, '[G]o[t]o Code [A]ction')


    -- Go to Definition
    map('gtd', vim.lsp.buf.definition, '[G]o[t]o [D]efinition')

    -- Go to Declaration
    map('gtD', vim.lsp.buf.declaration, '[G]o[t]o [D]eclaration')


    -- Go to implementation
    map('gti', vim.lsp.buf.implementation, '[G]o[t]o [I]mplementation')

    -- Highlight references word under cursor while cursor on the word
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method(
        'textDocument/documentHighlight',
        event.buf)
        then
            local highlight_augroup = vim.api.nvim_create_augroup(
                'kickstart-lsp-highlight',
                {clear = false})

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI'},{
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach',{
                group = vim.api.nvim_create_augroup(
                    'kickstart-lsp-detach',
                    {clear = true}),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds{
                        group = 'kickstart-lsp-highlight',
                        buffer = event2.buf}
                    end,
                })
            end
        end,
    })


require('nconf.plugin.LSP')

-- Autocomplete with blink
require('nconf.plugin.blink')
