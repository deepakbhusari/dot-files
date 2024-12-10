return {
  'echasnovski/mini.nvim',
      version = '*', -- Use for stability; omit to use `main` branch for the latest features
  requires = {
  },
  config = function()
    require('mini.files').setup()
  end,
}

