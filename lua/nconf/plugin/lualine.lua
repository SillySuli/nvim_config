local lualine_plugins = {
    gh 'nvim-tree/nvim-web-devicons',
    gh 'nvim-lualine/lualine.nvim'
}

-- Downloading lualine
vim.pack.add( lualine_plugins )

-- Setting and starting up Lualine
require('lualine').setup{
    options = {
        theme = 'horizon'
    }
}

