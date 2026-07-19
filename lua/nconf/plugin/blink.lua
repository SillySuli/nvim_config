-- [[ AutoComplete Engine ]]
vim.pack.add{{ src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' }}

require('blink.cmp').setup{
    keymap = {
        preset = 'default'
    },

    completion = {
        menu = {
            border = 'none',
        },

        -- <C-space> will show documentation, but can be changed to auto
        documentation = {
            auto_show = false,
            auto_show_delay_ms = 500,
            window = {
                border = 'none',
            },
        },
    },
    appearance = {
        nerd_font_variant = 'mono'
    },

    sources = {
        default= { 'lsp', 'path' }
    },

    fuzzy = { implementation = 'lua' },

    signature = { enabled = true },
}
