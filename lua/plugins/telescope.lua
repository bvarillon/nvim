-- lua/plugins/telescope.lua
return {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
    -- or                          , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = "Telescope",
    keys = {
        {"<leader>pf", function() require('telescope.builtin').find_files() end, desc = "[P]rojet Find [F]ile"},
        {"<leader>gf", function() require('telescope.builtin').git_files() end, desc = "[G]it Find [F]ile"},
        {"<leader>ps", function() require('telescope.builtin').grep_string({search = vim.fn.input("GREP > ")}) end, desc = "[P]roject [S]earch"},
        {"<leader>?",  function() require('telescope.builtin').oldfiles() end,  desc = '[?] Find recently opened files' },
        {"<leader><space>", function() require('telescope.builtin').buffers() end, desc = '[ ] Find existing buffers' },
        {"<leader>/", function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10, previewer = false,})
        end, desc = '[/] Fuzzily search in current buffer' },
        {"<leader>sh", function() require('telescope.builtin').help_tags() end, desc = '[S]earch [H]elp' }
    },
}
