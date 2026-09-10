-- Disable Copilot in projects containing a `.nocopilot` marker file.
-- Intended for practice repos (LeetCode, katas) where suggestions defeat the point.
-- Blocking the LSP attach silences both the inline ghost text and the
-- blink-cmp-copilot source in one place.
return {
	"zbirenbaum/copilot.lua",
	opts = {
		---@param bufnr integer
		---@param bufname string
		should_attach = function(bufnr, bufname)
			-- Preserve copilot.lua's own default guards
			if not vim.bo[bufnr].buflisted then
				return false
			end
			if vim.bo[bufnr].buftype ~= "" then
				return false
			end
			-- Per-project opt-out
			if bufname ~= "" and vim.fs.root(bufname, ".nocopilot") then
				return false
			end
			return true
		end,
	},
}
