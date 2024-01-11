return {
  'smoka7/multicursors.nvim',
   event = "VeryLazy",
  dependencies = { 
    'smoka7/hydra.nvim',
},
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
      cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
 keys = {
            {
                mode = { 'v', 'n' },
                '<Leader>m',
                '<cmd>MCstart<cr>',
                desc = 'Create a selection for selected text or word under the cursor',
            },
        },
  config = function()
    require('multicursors').setup {
    lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    --bottom_search = true, -- use a classic bottom cmdline for search
  },
    }
    -- Lua
  end,
}

