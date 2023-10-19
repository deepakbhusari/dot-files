local function setup()
    local telescope = require("telescope")
    -- import telescope actions safely
    local actions = require("telescope.actions")
    local telescope_actions = require("telescope.actions.set")
    -- import telescope-ui-select safely
    local themes = require("telescope.themes")
local fixfolds ={
hidden=true,
attach_mappings=function (_)
  telescope_actions.select:enhance({
   post= function() vim.cmd(":normal!zx") end
})
return true
end
}


 telescope.setup ({
       defaults = {
          vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
           },
             prompt_prefix = " >  ",
    selection_caret = "  ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    file_ignore_patterns = { "node_modules" },
    path_display = { "truncate" },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    mappings = {

    },
    pickers = {
        buffers=fixfolds,
        find_files = {
        --  find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--glob", "!.stack-work" },
        fixfolds
        },
        git_files=fixfolds,
        grep_string=fixfolds,
        live_grep=fixfolds,
        oldfiles=fixfolds,
    },
  },
  extensions = {
        ["ui-select"] = {
          themes.get_dropdown({}),
        },
  },
})

   -- telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("dap")


        -- set keymaps
    local keymap = vim.keymap -- for conciseness

     -- nvim-telescope/telescope.nvim
_G.telescope_find_files_in_path = function(path)
    local _path = path or vim.fn.input("Dir: ", "", "dir")
    require("telescope.builtin").find_files({search_dirs = {_path}})
end
_G.telescope_live_grep_in_path = function(path)
    local _path = path or vim.fn.input("Dir: ", "", "dir")
    require("telescope.builtin").live_grep({search_dirs = {_path}})
end
_G.telescope_files_or_git_files = function()
    local utils = require('telescope.utils')
    local builtin = require('telescope.builtin')
    local _, ret, _ = utils.get_os_command_output({
        'git', 'rev-parse', '--is-inside-work-tree'
    })
    if ret == 0 then
        builtin.git_files()
    else
        builtin.find_files()
    end
end


    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" }) -- find files within current working directory, respects .gitignore
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" }) -- find previously opened files
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" }) -- find string in current working directory as you type
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" }) -- find string under cursor in current working directory
    keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Show open buffers" }) -- list open buffers in current neovim instance
    keymap.set("n", "<leader>hf", "<cmd>Telescope marks<cr>", { desc = "Show marks" }) -- show harpoon marks
    keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Show git commits" }) -- list all git commits (use <cr> to checkout) ["gc" for git commits]
    keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", { desc = "Show git commits for current buffer" }) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
    keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Show git branches" }) -- list git branches (use <cr> to checkout) ["gb" for git branch]
    keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Show current git changes per file" }) -- list current changes per file with diff preview ["gs" for git status]

end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' ,
    { 'nvim-telescope/telescope-fzf-native.nvim', 
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-dap.nvim",
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-ui-select.nvim",

    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
    },
    config = setup,
    cmd = { "Telescope" }
}


