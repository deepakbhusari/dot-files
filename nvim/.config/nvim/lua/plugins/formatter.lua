return {
  'mhartington/formatter.nvim',
  opts = {},
  -- Optional dependencies
  dependencies = {  },

  keys={
  },
  config = function()
    -- Utilities for creating configurations
local util = require "formatter.util"

      require('formatter').setup{
         -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    -- Formatter configurations for filetype "lua" go here
    -- and will be executed in order
    lua = {
      -- "formatter.filetypes.lua" defines default configurations for the
      -- "lua" filetype
      require("formatter.filetypes.lua").stylua,

      -- You can also define your own configuration
      function()
        -- Supports conditional formatting
        if util.get_current_buffer_file_name() == "special.lua" then
          return nil
        end

        -- Full specification of configurations is down below and in Vim help files
        return {
          exe = "stylua",
          args = {
            "--search-parent-directories",
            "--stdin-filepath",
            util.escape_path(util.get_current_buffer_file_path()),
            "--",
            "-",
          },
          stdin = true,
        }
      end
    },
   javascript = {
            -- prettierd
            function()
                return {
                    exe = "prettierd",
                    args = {vim.api.nvim_buf_get_name(0)},
                    stdin = true
                }
            end
        },
        typescript = {
            -- prettierd
            function()
                return {
                    exe = "prettierd",
                    args = {vim.api.nvim_buf_get_name(0)},
                    stdin = true
                }
            end
        },
        json = {
            -- prettierd
            function()
                return {
                    exe = "prettierd",
                    args = {vim.api.nvim_buf_get_name(0)},
                    stdin = true
                }
            end
        },
        rust = {function() return {exe = "rustfmt", stdin = true} end},
          sql = {
            -- prettierd
            function()
                return {
                    exe = "sql-formatter",
                    args = {vim.api.nvim_buf_get_name(0)},
                    stdin = true
                }
            end
        },

    -- Use the special "*" filetype for defining formatter configurations on any filetype
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any filetype
--      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
} 

      --set keymaps
      local keymap=vim.keymap
      keymap.set("n","<leader>m","<cmd>Format<CR>")
      keymap.set("n","<leader>M","<cmd>FormatWrite<CR>")

  end
}

