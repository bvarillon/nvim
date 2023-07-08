-- map leader key
vim.g.mapleader = " "

-- lazy.nvim installation/configuration
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
   "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins") -- plugins are auto loaded from lua/plugins folder

-- personal settings in lua/rempa.lua and lua/set.lua
require("remap")
require("set")

-- lsp configuration using VonHeikemen/lsp-zero.nvim
local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()
