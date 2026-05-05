return {
	{ "lewis6991/async.nvim", lazy = true },
	{
		"ThePrimeagen/refactoring.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"lewis6991/async.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		keys = {
			{ "<leader>r", "", desc = "+refactor", mode = { "n", "x" } },
			{
				"<leader>rs",
				function() require("refactoring").select_refactor() end,
				mode = { "n", "x" },
				desc = "Select refactor",
			},
			{
				"<leader>re",
				function() return require("refactoring").extract_func() end,
				mode = { "n", "x" },
				desc = "Extract Function",
				expr = true,
			},
			{
				"<leader>rE",
				function() return require("refactoring").extract_func_to_file() end,
				mode = { "n", "x" },
				desc = "Extract Function To File",
				expr = true,
			},
			{
				"<leader>rv",
				function() return require("refactoring").extract_var() end,
				mode = { "n", "x" },
				desc = "Extract Variable",
				expr = true,
			},
			{
				"<leader>ri",
				function() return require("refactoring").inline_var() end,
				mode = { "n", "x" },
				desc = "Inline Variable",
				expr = true,
			},
			{
				"<leader>rI",
				function() return require("refactoring").inline_func() end,
				desc = "Inline Function",
				expr = true,
			},
			{
				"<leader>rp",
				function()
					return require("refactoring.debug").print_var({ output_location = "below" }) .. "iw"
				end,
				desc = "Debug Print Var (below)",
				expr = true,
			},
			{
				"<leader>rp",
				function()
					return require("refactoring.debug").print_var({ output_location = "below" })
				end,
				mode = "x",
				desc = "Debug Print Var (below)",
				expr = true,
			},
			{
				"<leader>rP",
				function() return require("refactoring.debug").print_loc({ output_location = "above" }) end,
				desc = "Debug Print Location",
				expr = true,
			},
			{
				"<leader>rc",
				function() return require("refactoring.debug").cleanup({ restore_view = true }) end,
				desc = "Debug Cleanup",
				expr = true,
				remap = true,
			},
		},
		opts = {
			prompt_func_return_type = {
				go = false,
				java = false,
				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			prompt_func_param_type = {
				go = false,
				java = false,
				cpp = false,
				c = false,
				h = false,
				hpp = false,
				cxx = false,
			},
			printf_statements = {},
			print_var_statements = {},
			show_success_message = true,
		},
		config = function(_, opts) require("refactoring").setup(opts) end,
	},
}
