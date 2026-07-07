-- [[ AutoComplete Engine ]]
vim.pack.add{{ src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' }}
require('blink.cmp').setup{
    keymap = {
        preset = 'default'
    },

    completion = {
        -- <C-space> will show documentation, but can be changed to auto
        documentation = {auto_show = false, auto_show_delay_ms = 500},
    },

    sources = {
        defualt = { 'lsp', 'path' }
    },

    fuzzy = { implementation = 'lua' },

    signature = { enabled = true },
}
