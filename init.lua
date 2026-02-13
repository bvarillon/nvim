-- map leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

require("mini.align").setup()
-- lsp configuration using VonHeikemen/lsp-zero.nvim
local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
--    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)

    lsp.default_keymaps({buffer=bufnr})

    local nmap = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>df', function() require('telescope.builtin').lsp_document_symbols({symbols={'function','method','constructor'}}) end, '[D]ocument [F]unctions')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    nmap('<leader>fr', require('telescope.builtin').lsp_references, '[F]ind [R]eference')

    -- See `:help K` for why this keymap
    nmap('K', function() vim.lsp.buf.hover({border = "rounded"}) end, 'Hover Documentation')
    nmap('<C-h>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end)


-- Configuration of systemd-language-server (not configurable with mason)
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

if not configs.systemd_ls then
  configs.systemd_ls = {
    default_config = {
      cmd = { 'systemd-language-server' },
      filetypes = { 'systemd' },
      root_dir = function() return nil end,
      single_file_support = true,
      settings = {},
    },
    docs = {
      description = [[
https://github.com/psacawa/systemd-language-server

Language Server for Systemd unit files.
]]
    }
  }
end

lspconfig.systemd_ls.setup {}

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'clangd'},
    handlers = {
        lsp.default_setup,
        lua_ls = function ()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
    sources ={
        {name = 'path'},
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'luasnip', keyword_length = 2},
        {name = 'buffer', keyword_length = 3},
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    window = {documentation = {border = "rounded"}},
})

cmp.event:on(
    'confirm_done',
    require('nvim-autopairs.completion.cmp').on_confirm_done()
)

vim.diagnostic.config(
    {
        underline = true,
        virtual_text = false,
        update_in_insert = false,
        severity_sort = true,
    }
)

--lsp.setup_nvim_cmp({
--  mapping = cmp_mappings
--})
--
--lsp.set_preferences({
--    suggest_lsp_servers = false,
--    sign_icons = {
--        error = 'E',
--        warn = 'W',
--        hint = 'H',
--        info = 'I'
--    }
--})
--
--lsp.setup()
