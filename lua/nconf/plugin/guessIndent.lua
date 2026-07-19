vim.pack.add{gh "NMAC427/guess-indent.nvim"}

require('guess-indent').setup {}


vim.keymap.set('n', '<leader>gi>', ':GuessIndent', {desc = '[G]uess [I]ndent'})
