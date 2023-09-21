return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'p00f/nvim-ts-rainbow'
    },
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "cpp" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            rainbow = {
                enable = true,
                extended_mode = true,
                max_file_lines = nil,
            }
        })
    end
}
