return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
        require("todo-comments").setup({
    	keywords = {
        		OPTIMATE = { icon = "?", color = "opti", alt = { "OPTMATE" } },
        	},
        merge_keywords = true,
        highlight = {
            multiline = false,
            -- pattern = [[.{-}(\s?(KEYWORDS))]],
            pattern = [[(<(KEYWORDS)>)]],
        },
        colors = {
            opti = {"@text.note.comment"},
        },
        pattern = [[\b(KEYWORDS)\b]],
        })
    end,
}
