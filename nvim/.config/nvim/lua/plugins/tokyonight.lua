 return {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
--vim.g.tokyonight_style = 'storm'
--vim.g.tokyonight_style = 'moon'
--vim.g.tokyonight_style = 'night'
--vim.g.tokyonight_style = 'day'
vim.g.tokyonight_enable_italic=1

     vim.cmd([[colorscheme tokyonight-moon]])
    end,
  }


