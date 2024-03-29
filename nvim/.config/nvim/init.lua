-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.loader then
  vim.loader.enable()
end

require ('settings')
require ('config/plugins_lazy')

