vim.opt.timeoutlen=500

vim.o.background = "light"
vim.cmd.colorscheme("gruvbox")
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = false

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.o.completeopt = 'menuone,noselect'

vim.g.python3_host_prog = "C:\\Users\\benoi\\AppData\\Local\\Microsoft\\WindowsApps\\python3.exe"
