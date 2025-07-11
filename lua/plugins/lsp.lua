return{
    {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
        {'neovim/nvim-lspconfig'},
        {
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'},
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'hrsh7th/cmp-buffer'},
        {'hrsh7th/cmp-path'},
        {'saadparwaiz1/cmp_luasnip'},
        {'L3MON4D3/LuaSnip'},
        {'hrsh7th/cmp-nvim-lua'},
        {'rafamadriz/friendly-snippets'}

    }},
    {'TomDeneire/lsp-in-gutter.nvim',
    config = true,}
}
