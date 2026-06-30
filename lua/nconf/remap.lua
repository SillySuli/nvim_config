-- ( Lua containing all persomal remap )

vim.keymap.set("n", "<leader>dl", vim.cmd.Ex, { desc = "Go to Directory listing" } ) -- ( dl = "directory listing" )
vim.keymap.set("n", '<Esc>', vim.cmd.noh, { desc = "Clear all highlight when Esc is pressed"} )

-- Disabling Arrows keys in normal mode
-- Note: <CR> means carrige reutrn, equivalent to pressing enter
vim.keymap.set( 'n', '<left>', '<cmd>echo "Use h to move left!" <CR>')
vim.keymap.set( 'n', '<right>', '<cmd>echo "Use l to move right!" <CR>')
vim.keymap.set( 'n', '<up>', '<cmd>echo "use k to move up!" <CR>')
vim.keymap.set( 'n', '<down>', '<cmd>echo "use j to move down!" <CR>')

-- Quick setting to get config editing
vim.keymap.set( 'n', '<leader>rc', ':e ~/.config/nvim/lua/nconf/remap.lua<CR>')
