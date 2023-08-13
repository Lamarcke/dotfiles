return {
    'numToStr/Comment.nvim',
    dependencies = {

        "JoosepAlviste/nvim-ts-context-commentstring"
    },
    lazy = false,
    config = function()
        local comment = require("Comment")
        comment.setup({
            -- Integration with nvim-ts-context-commentstring
            -- Works specially well for JSX/TSX
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        })
    end
}
