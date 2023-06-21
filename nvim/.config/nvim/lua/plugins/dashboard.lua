return {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
--      theme = 'hyper',
--shortcut = {
--    { desc = string, group = 'highlight group', key = 'shortcut key', action = 'action when you press key' },
--  },
  packages = { enable = true }, -- show how many plugins neovim loaded
  project = { enable = true, limit = 20, icon = 'your icon', label = '', action = 'Telescope find_files cwd=' },
  mru = { limit = 20, icon = 'your icon', label = '', },
  footer = {}, -- footer
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}

