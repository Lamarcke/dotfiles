return {
    "nvim-lualine/lualine.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("lualine").setup({
            theme = "kanagawa"
        })
    end,
}
