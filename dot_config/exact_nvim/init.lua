-- Utility debugging functions (https://github.com/folke/snacks.nvim/blob/main/docs/debug.md)
-- Pretty print an object
_G.dd = function(...)
	Snacks.debug.inspect(...)
end
_G.bt = function()
	Snacks.debug.backtrace()
end
vim.print = _G.dd

-- Enable detailed LSP logging
vim.lsp.set_log_level("debug")
require('vim.lsp.log').set_format_func(vim.inspect)

require("config.lazy")

vim.cmd([[colorscheme habamax]])
