vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.g.mapleader = ' '

vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

require("plugins")


vim.api.nvim_create_autocmd("FileType", {

	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })

	end,

})
