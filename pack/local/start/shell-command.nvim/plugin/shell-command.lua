vim.keymap.set('v', "<Plug>(ShellCmd)", function ()
    require('shell-command').shell_command()
end, { desc = "Execute shell commande on visual selection" })
