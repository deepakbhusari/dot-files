      return {
        "telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
          ,
          --build = "cmake",
          config = function()
            local telescope = require("telescope")
            --require("telescope").load_extension("fzf")
              telescope.load_extension("fzf")
              telescope.load_extension("ui-select")
              telescope.load_extension("dap")
              telescope.load_extension("neoclip")

          end,
        },
      }

