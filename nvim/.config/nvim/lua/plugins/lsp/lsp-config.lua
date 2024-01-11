return {
   {
  -- Setup Mason and Mason-Config.
  'williamboman/mason.nvim',
  dependencies = {
--    'williamboman/mason-lspconfig.nvim',
--    'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    -- import mason plugin safely
    local mason = require 'mason'

    -- import mason-lspconfig plugin safely
    --local mason_lspconfig = require 'mason-lspconfig'

    -- import mason-null-ls plugin safely
--    local mason_null_ls = require 'mason-null-ls'

    -- enable mason
    mason.setup()
    --require("mason").setup()

   -- require("mason-lspconfig").setup {
      -- list of servers for mason to install
   --   ensure_installed = {
     --   'stylua',
     --   'selene',
		--		"luacheck",
		--		"shellcheck",
		--		"shfmt",
      --  'svelte',

    --  },
      -- auto-install configured servers (with lspconfig)
     -- automatic_installation = true, -- not the same as ensure_installed
    --}

    --mason_null_ls.setup {
      -- list of formatters & linters for mason to install
    --  ensure_installed = {
    --    'prettier', -- ts/js formatter
    --    'stylua', -- lua formatter
    --    'eslint_d', -- ts/js linter
    --  },
      -- auto-install configured servers (with lspconfig)
   --   automatic_installation = true,
   -- }
  end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    keys = {
      {"<leader>i", "<cmd>LspInfo<cr>", "Lsp Info"},
      {"<leader>I", "<cmd>LspInstall<cr>", "Lsp Install"},
    },
      config=function()
        require("mason-lspconfig").setup {
          -- list of servers for mason to install
          ensure_installed = {
       --   'stylua',
       --   'selene',
				--  'tailwindcss-language-server',
				--  'typescript-language-server',
       -- 'css-lsp',
            'tsserver',
            'lua_ls',
            'html',
            'cssls',
            'tailwindcss',
            'graphql',
            'emmet_ls',
            'prismals',
            'clangd',
            'pyright',
            'rust_analyzer'
           },
           automatic_installation = true,
          handlers = {
          --lsp_zero.default_setup,
         -- lua_ls = function()
         -- local lua_opts = lsp_zero.nvim_lua_ls()
          --require('lspconfig').lua_ls.setup(lua_opts)
       -- end,
         },
      }
      end,
     },
     { -- LSP Support
--    'VonHeikemen/lsp-zero.nvim',
--    branch = 'v3.x',
--    lazy = true,
--    config = false,
--    keys = {
--      {"<leader>i", "<cmd>LspInfo<cr>", "Lsp Info"},
--      {"<leader>I", "<cmd>LspInstall<cr>", "Lsp Install"},
--    },
--    dependencies = {
--      'williamboman/mason.nvim',
--      'williamboman/mason-lspconfig.nvim',
--    },
--    config=function()
      -- Use lsp_zero to manage lsp attachments.
--      local lsp_zero = require('lsp-zero')

--      lsp_zero.on_attach(function(_, bufnr)
--      lsp_zero.default_keymaps({buffer = bufnr})
--      end)

--     require('mason').setup({})
--        require('mason-lspconfig').setup({
--          ensure_installed = {
--            'tsserver', 
--            'lua_ls',
--            'html',
--            'cssls',
--            'tailwindcss',
--            'graphql',
--            'emmet_ls',
--            'prismals',
--            'clangd', 
--            'pyright', 
--            'rust_analyzer'},
--          handlers = {
--            lsp_zero.default_setup,
--          },
--        })
--    end,

  },

  { -- LSP Config
    'neovim/nvim-lspconfig',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    },
    config=function()
     local lspconfig=require("lspconfig")
     lspconfig.lua_ls.setup({})
     vim.keymap.set('n','K',vim.lsp.buf.hover,{})
     vim.keymap.set('n','gd',vim.lsp.buf.definition,{})
     vim.keymap.set({'n','v'},'<leader>ca',vim.lsp.buf.code_action,{})
     lspconfig.tsserver.setup({})
    end,

  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'L3MON4D3/LuaSnip'}
    },
  },
   { -- Use which-key to show lsp_zero default_keymaps
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = function()
      require('which-key').setup(
      {plugins = {spelling = true}}
      )
    end,
  },

  { -- Vim/NeoVim/Tmux seamless navigation.
    "christoomey/vim-tmux-navigator",
    event =  "VeryLazy",
    keys = {
      {"<c-h>", "<cmd>TmuxNavigateLeft<cr>", "Navigate Window Left"},
      {"<c-j>", "<cmd>TmuxNavigateDown<cr>", "Navigate Window Down"},
      {"<c-k>", "<cmd>TmuxNavigateUp<cr>", "Navigate Window Up"},
      {"<c-l>", "<cmd>TmuxNavigateRight<cr>", "Navigate Window Right"},
    },
  },
   { -- File navigation
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim"
    },
    keys = {
      -- {"<c-n>", "<cmd>Neotree toggle<cr>"},
      {"<leader>nt", "<cmd>Neotree focus<cr>"},
    },

    opts = function(_, opts)
      opts.filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true}
      }
      opts.window = { position = "right", }
    end,
  },

  {
--    'williamboman/mason-lspconfig.nvim',
--      config=function()
--    require('mason-lspconfig').lua_ls.setup({})
--    end,
-- Setup Mason and Mason-Config.
--require('mason').setup({})
--require('mason-lspconfig').setup({
--  handlers = {
--    lsp_zero.default_setup,
--    lua_ls = function()
--      local lua_opts = lsp_zero.nvim_lua_ls()
--      require('lspconfig').lua_ls.setup(lua_opts)
--    end,
--  }),
   },
}

