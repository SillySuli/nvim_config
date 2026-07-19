-- ( Lua containing all persomal remap )

-- Remap to go to nvim's directory listing
vim.keymap.set("n", "<leader>ef", vim.cmd.Ex, { desc = "[E]plore [F]iles" } ) -- ( dl = "directory listing" )

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

-- Diagnostic buffer opening
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1})
end, { desc = 'Next diagnostic' })

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, })
end, { desc = 'Previous diagnostic' })

vim.keymap.set('n', "<leader>e", vim.diagnostic.open_float,
    { desc = 'Show diagnostic [E]rror message' })


-- ============================================================================
-- Buffers
-- ============================================================================

-- View all buffers
vim.keymap.set('n', "<leader>vb", ":buffers<CR>" , {desc = "[V]iew [B]uffers"})

-- Close all buffers except current 1.
vim.keymap.set('n', "<leader>bc", ":%bd|e#|bd#<CR>" , {desc = "[B]uffer [C]lose"})

-- shifting through buffers
vim.keymap.set('n', "<leader>b", ":b " , {desc = "[B]uffer shifting"})
