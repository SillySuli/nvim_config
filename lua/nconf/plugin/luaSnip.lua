-- Download LuaSnip
vim.pack.add{
    { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*'}
}

require("luasnip.loaders.from_lua").load({
    paths = vim.fn.stdpath("config").. "/after/snippets",
})
require('luasnip').setup{}
