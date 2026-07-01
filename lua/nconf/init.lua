-- (Lua config)

vim.g.mapleader = " "
-- vim.g.maplocalleader = ","  -- ( If you ever decide to use a more niche control over certain filetypes )

require("nconf.remap")
require("nconf.set")
-- require("nconf.lazy")


-- Attempt migrating to vim.pack

-- Place Auto command here if you have any later


-- Helper function to reduce repetition
function gh(repo) return 'https://github.com/' .. repo end

-- Include Telescope
require('nconf.plugin.telescope')

-- Include colour Scheme
require('nconf.plugin.kanagawa')

