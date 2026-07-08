vim.pack.add{gh "rebelot/kanagawa.nvim"}

require('kanagawa').setup({

    theme = "dragon",
    background = {
        dark = "dragon",
        light = "lotus"
    },
    overrides = function(colors)
        local theme = colors.theme
        return{
            -- Blink completion menu ( Apperance )
            BlinkCmpMenu          = { bg = theme.ui.bg_p1 },
            BlinkCmpMenuBorder    = { fg = theme.ui.special },
            BlinkCmpMenuSelection = { bg = theme.ui.bg_search },
            BlinkCmpLabel         = { fg = theme.ui.fg },
        }
    end,

})

vim.cmd("colorscheme kanagawa")

