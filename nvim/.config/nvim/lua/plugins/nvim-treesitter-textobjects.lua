local function setup()
  --local telescope = require 'nvim-treesitter-textobjects'
  --local telescope = require 'nvim-treesitter'
  -- import telescope actions safely
  --local actions = require 'telescope.actions'
  -- import telescope-ui-select safely
  --local themes = require 'telescope.themes'
  local tr_configs = require 'nvim-treesitter.configs'

  -- require
  tr_configs.setup {
    -- ('nvim-treesitter.configs')
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
          ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
        },
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
          ['@class.outer'] = '<c-v>',
        },
      },
    },
  }
  -- set keymaps
  local keymap = vim.keymap -- for conciseness

  --    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" }) -- find files within current working directory, respects .gitignore
  --    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" }) -- find previously opened files
end

return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  after = 'nvim-treesitter',
  event = 'VeryLazy',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = setup,
  --cmd = { "Telescope" }
}
