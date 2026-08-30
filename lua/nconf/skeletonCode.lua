
-- Html skeleton code
--[[
vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = "*.html",
    callback = function()
        local template_path = vim.fn.expand("~/.config/nvim/templates/skeleton.html")
        vim.cmd("0read" .. template_path)
    end,
})
--]]

function html_boiler()
        local template_path = vim.fn.expand("~/.config/nvim/templates/skeleton.html")
        vim.cmd("0read" .. template_path)
end
