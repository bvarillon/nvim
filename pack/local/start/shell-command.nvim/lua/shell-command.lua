M = {}

---Return the current text selected in visual selection
---@return string[]
local function get_visual()
	local mode = vim.api.nvim_get_mode().mode
	assert(
		mode:match("^v") or mode:match("^V") or mode:match(vim.keycode("^<c-v>")),
		"Should only be called on visual char, visual line or visual block mode"
	)
	local text = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = mode })
    return text
end

---Split a sting in a table of lines and compute the lenght of the longer line
---@param str string The  string to split
---@return string[]  lines The list of lines
---@return integer max The length of the longer lines
local function split(str)
    local lines = {}
    local max = 0
    for line in string.gmatch(str, "[^\r\n]+" ) do
        table.insert(lines,line)
        max = math.max(#line, max)
    end
    return lines ,max
end

---Create a center floating window containing text.
---The window is centered on the ui and its size fits the text.
---@param title string Title of the windows
---@param message string Text of the window 
local function floating(title, message)
    local lines, max = split(message)
    local buf = vim.api.nvim_create_buf(false,true)
    vim.api.nvim_buf_set_lines(buf,0,0,false,lines)
    vim.api.nvim_buf_set_keymap(buf, 'n', '<ESC>', ':close<CR>',{silent=true, nowait=true,noremap=true})
    local ui = vim.api.nvim_list_uis()[1]
    local height = #lines
    -- local width = math.max(80,max)
    local width = max
    local opts = {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor((ui.width - width)/2),
        row = math.floor((ui.height - height)/2),
        title = title,
        title_pos="left",
        style="minimal",
    }
    vim.api.nvim_open_win(buf,true,opts)

end

---Ask for a command and execute in the shell passing it the input.
---Input text is put at the place of 'pattern'(default'<V>) in 'cmd'.
---If 'pattern' not found in 'cmd', 'input' is added after it with a space.
---@param cmd string The command to execute
---@param input string Input to pass to the command through stdin
---@return string output The output of the command
local function exec_command(cmd,input)
    input = string.format("%q",input)
    if cmd:find(M.pattern) then
        cmd = cmd:gsub(M.pattern, input)
    else
        cmd = cmd .. " "..input.." "
    end
    cmd = cmd .. " 2>&1"
    local p = io.popen(cmd,'r')
    local output = p:read('*a')
    p:close()
    return output
end

local function shell_command()
    local lines = get_visual()
    local txt = table.concat(lines,"\n")
    local cmd = vim.fn.input("Command : ")
    -- local result = vim.fn.system({cmd, txt})
    local result = exec_command(cmd,txt)
    if result == "" then
        result ="No output !"
    end
    floating(cmd,result)
end

-- vim.api.nvim_create_user_command('ShellCmd', shell_command,{
--     nargs = "?",
--     desc = "Execute bash command"
-- })

-- vim.keymap.set('v', "<Plug>(ShellCmd)", shell_command, { desc = "Execute shell commande on visual selection" })

M.tmpfile = "/tmp/visualshellinput"
M.pattern = "<V>"
M.shell_command = shell_command
return M

