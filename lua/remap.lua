vim.keymap.set("n","<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

vim.keymap.set("n", "<leader>x", ":.lua<CR>", {desc = "Lua: execute line"})
vim.keymap.set("v", "<leader>x", ":lua<CR>", {desc ="Lua: execute selection"})
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>", {desc = "Lua: source current file"})

print "salut"
print "hello"
