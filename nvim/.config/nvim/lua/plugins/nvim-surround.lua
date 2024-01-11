return {
  'kylechui/nvim-surround',
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
   event = "VeryLazy",
  dependencies = { },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    require('nvim-surround').setup {
    lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
  },
    }
    -- Lua
  end,
}

