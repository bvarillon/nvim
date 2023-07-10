-- return {
--     "Civitasv/cmake-tools.nvim",
--     opts = {
--         cmake_build_directory = "build",
--         cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
--     }
-- }
-- return {
--     "cdelledonne/vim-cmake",
--     config = function ()
--         vim.g.cmake_link_compile_commands = 1
--         vim.g.cmake_build_dir_location = "build"
--     end
-- }
return {
    "Shatur/neovim-tasks",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    config = function()

        local Path = require('plenary.path')
        require('tasks').setup({
            default_params = { -- Default module parameters with which `neovim.json` will be created.
                cmake = {
                    cmd = 'cmake', -- CMake executable to use, can be changed using `:Task set_module_param cmake cmd`.
                    build_dir = tostring(Path:new('{cwd}', 'build', '{os}-{build_type}')), -- Build directory. The expressions `{cwd}`, `{os}` and `{build_type}` will be expanded with the corresponding text values. Could be a function that return the path to the build directory.
                    build_type = 'Debug', -- Build type, can be changed using `:Task set_module_param cmake build_type`.
                    args = { -- Task default arguments.
                        configure = { '-D', 'CMAKE_EXPORT_COMPILE_COMMANDS=1' },
                    },
                },
            },
            save_before_run = true, -- If true, all files will be saved before executing a task.
            params_file = 'neovim.json', -- JSON file to store module and task parameters.
            quickfix = {
                pos = 'botright', -- Default quickfix position.
                height = 12, -- Default height.
            }})
    end
}
