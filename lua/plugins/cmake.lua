-- return {
--     "Civitasv/cmake-tools.nvim",
--     opts = {
--         cmake_build_directory = "build",
--         cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
--     }
-- }
return {
    "cdelledonne/vim-cmake",
    config = function ()
        vim.g.cmake_link_compile_commands = 1
        vim.g.cmake_build_dir_location = "build"
    end
}
