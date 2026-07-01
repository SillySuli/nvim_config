-- -- Installation
-- "nvim-telescope/telescope.nvim",
-- tag = "0.2.2",
-- dependencies = { "nvim-lua/plenary.nvim",
-- "nvim-telescope/telescope-ui-select.nvim",
-- "nvim-telescope/telescope-file-browser.nvim",
-- },
local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
    gh 'nvim-telescope/telescope-file-browser.nvim',
}

vim.pack.add(telescope_plugins)

-- Configuration
require('telescope').setup({
    -- Where you can configure telescope itself, and change/override
    -- mappings and picker behaviours
    extensions = {
        -- Visually configuring the pop-up LSP picker form generic nvim to telescope pop-up
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
        file_browser = {
            theme = 'ivy',
            -- disabling netrw and usnig telescope file brower in its place
            -- hijack_netrw = true,
        }
    },
})

-- Activiting any extenstions, if they installed
pcall( require('telescope').load_extension, 'ui-select')
pcall( require('telescope').load_extension, 'file_browser') -- If this annoys you later remove it

-- see :help telescope.builtin
local builtin = require( 'telescope.builtin' )
vim.keymap.set( 'n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set( 'n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set( 'n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })

-- Normal file browser
-- vim.keymap.set( 'n', '<leader>fb', ':Telescope file_browser<CR>',  { desc = '[F]ile [B]rowse' })

-- Open file bwoser with the path of current buffer.
vim.keymap.set( 'n', '<leader>fb'
, ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
{ desc = '[F]ile [B]rowse' })
