return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            themeable = true,
            separator_style = "thin",
            diagnostics = "nvim_lsp",
            custom_filter = function(buf_number, buf_numbers)
                if vim.bo[buf_number].filetype ~= "oil" then
                    return true
                end
            end,
        }
    }
}
