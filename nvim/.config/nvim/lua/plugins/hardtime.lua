-- lazy.nvim
return {
  "m4xshen/hardtime.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  opts =
  {
    restricted_keys = {
      ["<C-P>"] = {},
    },
    -- Add "oil" to the disabled_filetypes
    disabled_filetypes = { "qf", "netrw", "NvimTree", "lazy", "mason", "oil" },
    disabled_keys = {
      ["<Up>"] = {},
      ["<C-P>"] = {},
      --   ["<Space>"] = { "n", "x" },
    },
  }
}

