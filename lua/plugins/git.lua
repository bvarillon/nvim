return {
	"tpope/vim-fugitive",
	keys = {
		{"<leader>gs", vim.cmd.Git, desc = "[G]it [S]tatus"}
	},
    {
  "rbong/vim-flog",
  lazy = true,
  cmd = { "Flog", "Flogsplit", "Floggit" },
  dependencies = {
    "tpope/vim-fugitive",
  },
},
}
