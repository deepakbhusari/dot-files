return {
  'akinsho/toggleterm.nvim',
  version = '',
  opts = {},
  event = 'VeryLazy',
  config = function()
    require('toggleterm').setup {
      size = 14,
      open_mapping = [[<c-t>]],
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = '1',
      start_in_insert = true,
      persist_size = true,
      direction = 'float',
      close_on_exit = false, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'curved',
        width = 100,
        winblend = 3,
        highlights = {
          border = 'Normal',
          background = 'Normal',
        },
      },
    }
  end,
}
