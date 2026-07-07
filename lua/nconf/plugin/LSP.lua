-- List of servers you want to enable
-- see :help lsp-config on how to configure
local servers = {
    clangd = {},    -- C/C++ projects
    pyright = {},   -- Python
    bashls = {},    -- bash lsp (fixed: was 'bash', correct name is 'bashls')
    jdtls = {},     -- Java lsp
    -- Special Lua config recommended by neovim.
    -- Specifically fine tune to edit nvim config files
    -- Letting the Lua server know it is running inside nvim config
    lua_ls = {
        -- on_init runs once when an lsp attaches to a buffer
        on_init = function(client)
            -- Disable fromatting as stylua will handle it.
            client.server_capabilities.documentFormattingProvider = false
            if client.workspace_folders then
                local path = client.workspace_folders[1].name
                -- If not in your config directory, do not apply special rules
                if path ~= vim.fn.stdpath 'config' and
                    ( vim.uv.fs_stat(path .. '/.luarc.json') or
                    vim.uv.fs_stat(path .. '/.luarc.jsonc'))
                    then return
                end
            end
            local runtimefiles = vim.tbl_filter(function(d)
                return not d:match(
                    vim.fn.stdpath('config') .. '/?a?f?t?e?r?')
            end, vim.api.nvim_get_runtime_file('', true))
            -- Which version of Lua to use
            client.config.settings.Lua = vim.tbl_deep_extend(
                'force', client.config.settings.Lua, {
                    runtime = {
                        version = 'LuaJIT',
                        path = { 'lua/?.lua', 'lua/?/init.lua' },
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = vim.tbl_extend(
                            'force',
                            runtimefiles,
                            { '${3rd}/luv/library',
                              '${3rd}/busted/library', }
                        ),
                    },
                })
        end,
        -- remove styling on the config level
        -- stylua handles it
        settings = {
            Lua = {
                format = { enable = false },
            },
        },
    },
}

-- Install lsp and mason
-- Mason is core pack manager
-- Mason-tool-installer specificing which tool should alway be installed.
vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

-- Auto install LSPs and related tools to stdpath for nvim
require('mason').setup{}    -- fixed: requie → require

local installed = vim.tbl_keys(servers or {})
-- stylua added here since it is a formatter not an LSP server
-- can extend list if wanted..
vim.list_extend( installed, {
    'stylua',
})

require('mason-tool-installer').setup { ensure_installed = installed }

for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
end
