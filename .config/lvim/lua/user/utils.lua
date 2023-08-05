local M = {}

M.dap_continue = function()
    if vim.fn.filereadable('.vscode/launch.json') then
        require('dap.ext.vscode').load_launchjs()
    end
    require('dap').continue()
end

return M
