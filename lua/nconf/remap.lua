-- ( Lua containing all persomal remap )

-- Remap to go to nvim's directory listing
vim.keymap.set("n", "<leader>dl", vim.cmd.Ex, { desc = "Go to Directory listing" } ) -- ( dl = "directory listing" )

-- Escaping all highlighting
vim.keymap.set("n", '<Esc>', vim.cmd.noh, { desc = "Clear all highlight when Esc is pressed"} )

-- Disabling Arrows keys in normal mode
-- Note: <CR> means carrige reutrn, equivalent to pressing enter
vim.keymap.set( 'n', '<left>', '<cmd>echo "Use h to move left!" <CR>')
vim.keymap.set( 'n', '<right>', '<cmd>echo "Use l to move right!" <CR>')
vim.keymap.set( 'n', '<up>', '<cmd>echo "use k to move up!" <CR>')
vim.keymap.set( 'n', '<down>', '<cmd>echo "use j to move down!" <CR>')

-- Quick setting to get config editing
vim.keymap.set( 'n', '<leader>rc', ':e ~/.config/nvim/lua/nconf/remap.lua<CR>')

-- Moving entire lines up or down
vim.keymap.set( 'v', 'K', ":m '>+1<CR>gv=gv", { desc = "Move line Up"})
vim.keymap.set( 'v', 'J', ":m '<-2<CR>gv=gv", { desc = "Move line down"})

-- Highlight Yank Text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight text on yank",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", {clear = true}),
    callback = function()
        vim.highlight.on_yank()
    end,
})

