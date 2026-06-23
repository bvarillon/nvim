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

-- require("lazy").setup("plugins") -- plugins are auto loaded from lua/plugins folder
require("lazy").setup({spec="plugins",performance={reset_packpath=false}}) -- deactivate reset_packpath to allow loading plugin from local pack/ folder

vim.cmd.packadd('shell-command.nvim')

-- personal settings in lua/rempa.lua and lua/set.lua
require("remap")
require("set")

require("mini.align").setup()

vim.lsp.config("*", {
    capabilities = require("cmp_nvim_lsp").default_capabilities()
})
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local nmap = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
        nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        nmap('<leader>df', function() require('telescope.builtin').lsp_document_symbols({symbols={'function','method','constructor'}}) end, '[D]ocument [F]unctions')
        nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
        nmap('<leader>fr', function() require('telescope.builtin').lsp_references({jump_type='never', include_current_line=true}) end, '[F]ind [R]eference')

        -- See `:help K` for why this keymap
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        -- nmap('K', function() vim.lsp.buf.hover({border = "rounded"}) end, 'Hover Documentation')
        nmap('<C-h>', vim.lsp.buf.signature_help, 'Signature Documentation')

        -- Lesser used LSP functionality
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(event.buf, 'Format', function(_)
            vim.lsp.buf.format()
        end, { desc = 'Format current buffer with LSP' })

        vim.lsp.completion.enable(true, event.data.client_id, event.buf, {autotrigger=true})
    end
})

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'clangd', 'lua_ls'},
})

local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBvisual keymapehavior.Select}
--
-- require('luasnip.loaders.from_vscode').lazy_load()
--
cmp.setup({
    sources ={
        {name = 'path'},
        {name = 'nvim_lsp'},
--         {name = 'nvim_lua'},
--         {name = 'luasnip', keyword_length = 2},
        {name = 'buffer', keyword_length = 3},
    },
--     mapping = cmp.mapping.preset.insert({
--         ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--         ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--         ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--         ["<C-Space>"] = cmp.mapping.complete(),
--     }),
        mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    }),
    window = {documentation = {winhighlight = "Normal:Folded"}},
})

-- cmp.event:on(
--     'confirm_done',
--     require('nvim-autopairs.completion.cmp').on_confirm_done()
-- )

vim.diagnostic.config(
    {
        underline = true,
        virtual_text = false,
        update_in_insert = false,
        severity_sort = true,
    }
)

vim.keymap.set('v', "<leader>ex", "<Plug>(ShellCmd)")

