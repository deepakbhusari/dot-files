local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' ' -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.o.termguicolors = true

require('lazy').setup {
  spec = {
    {
      'LazyVim/LazyVim',
      -- import = 'lazyvim.plugins',

      -- import = 'plugins',
      -- import = 'plugins.lsp',
      opts = {
        colorscheme = 'nightfly',
        news = {
          lazyvim = true,
          neovim = true,
        },
      },
    },

    { import = 'lazyvim.plugins.extras.linting.eslint' },
    --    { import = 'lazyvim.plugins.extras.formatting.prettier' },
    --    { import = 'lazyvim.plugins.extras.lang.typescript' },
    { import = 'lazyvim.plugins.extras.lang.json' },
    { import = 'lazyvim.plugins.extras.lang.tailwind' },
    -- { import = 'lazyvim.plugins.extras.coding.copilot' },
    -- { import = 'lazyvim.plugins.extras.util.mini-hipatterns' },
    { import = 'plugins' },
    { import = 'plugins.lsp' },
  },
  --{ import = 'lazyvim.plugins.extras.ui.mini-animate' },

  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  dev = {
    path = '~/.ghq/github.com',
  },
  -- install = { colorscheme = { "catppuccin", "tokyonight", "habamax" } },
  -- install = { colorscheme = { 'nightfly','catppuccin', 'tokyonight' } },
  -- install = { colorscheme = { 'nightfly', 'catppuccin' } },
  checker = {
    enabled = true, -- automatically check for plugin updates
    notify = false, -- don't notify
  },
  change_detection = {
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        'rplugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  debug = false,
}
