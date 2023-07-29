local function getWords()
  return tostring(vim.fn.wordcount().words)
end

return {
  {
    "nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup()

  --  opts = function(_, opts)
      --table.insert(opts.sections.lualine_x, "😄")
    end,
  },
}

