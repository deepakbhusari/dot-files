local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct

--local plugins = {
--  'nvim-tree/nvim-tree.lua',
--  'nvim-tree/nvim-web-devicons',
--  'nvim-lualine/lualine.nvim',
--  'nvim-treesitter/nvim-treesitter',
--}
--local opts = {}

require('lazy').setup {
  spec = {
    -- add LazyVim and import its plugins
    -- The folder can be custom.plugins or plugins
    { import = 'plugins' },
    -- import/override with your plugins
    --    { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
    -- import any extras modules here
    -- { import = 'lazyvim.plugins.extras.lang.typescript' },
    --{ import = 'lazyvim.plugins.extras.lang.json' },
    --{ import = 'lazyvim.plugins.extras.ui.mini-animate' },
    --{ import = 'lazyvim.plugins.extras.linting.eslint' },
    --{ import = 'lazyvim.plugins.extras.formatting.prettier' },
    
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- install = { colorscheme = { "catppuccin", "tokyonight", "habamax" } },
  install = { colorscheme = { 'catppuccin', 'tokyonight' } },
  checker = {
    enabled = true, -- automatically check for plugin updates
    -- notify = false, -- don't notify
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}

