return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-tree/nvim-web-devicons"}, -- not strictly required, but recommended
        {"MunifTanjim/nui.nvim"}
    },
    cmd = "Neotree",
    keys = {
        {
            "<leader>fe",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
            end,
            desc = "[F]ile [E]xplorer (NeoTree)",
        },
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true})
    end
}
