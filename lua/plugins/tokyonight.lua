return {
	"folke/tokyonight.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	config = function()
	-- load the colorscheme here
   local tokyotheme = require("tokyonight")

    tokyotheme.setup({
      on_colors = function (colors)
        colors.fg_gutter = "#b2b8cf"
      end
    })

		vim.cmd([[colorscheme tokyonight]])
	end,
}

