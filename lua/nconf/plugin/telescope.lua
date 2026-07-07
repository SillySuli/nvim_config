-- -- Installation

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
vim.keymap.set( 'n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set({'n', 'v'}, '<leader>sw', builtin.grep_string, {desc = '[S]earch current [W]ord'})
vim.keymap.set('n', '<leader><leader>', builtin.buffers, {desc = '[ ] Find existing buffers'})

-- Normal file browser
-- vim.keymap.set( 'n', '<leader>fb', ':Telescope file_browser<CR>',  { desc = '[F]ile [B]rowse' })

-- Open file bwoser with the path of current buffer.
vim.keymap.set( 'n', '<leader>fb'
, ':Telescope file_browser path=%:p:h select_buffer=true<CR>',
{ desc = '[F]ile [B]rowse' })

-- Override default behaviour and theme when searching
vim.keymap.set('n', '<leader>/', function()
    -- Can further customise if you want
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end,{desc = '[/] Fuzzily search in current buffer'})

-- Search open buffers.
vim.keymap.set('n', '<leader>s/', function()
    -- Can further customise if you want
    builtin.live_grep { 
        grep_open_files = true,
        prompt_title = 'Liv Grep in Open Files',
    }
end,{desc = '[S]earch [/] in open files'})


