return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Disable lazy loading as recommended
    ft = { "markdown", "typst", "html", "latex" }, -- Load for these file types
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- Define the presets
      local presets_headings = require("markview.presets").headings
      local presets_hr = require("markview.presets").horizontal_rules

      -- Setup markview with all desired configurations
      require("markview").setup({
        -- Configure markdown specific options
        markdown = {
          headings = presets_headings.slanted, -- Use the slanted heading preset
          horizontal_rules = presets_hr.arrowed, -- Use the arrowed HR preset
        },
        -- html and latex support are enabled by default if the parsers are installed
        -- You just need to ensure the treesitter parsers are present (see below)
      })

      -- Optional: Automatically enable Markview for all relevant buffers on startup
      vim.cmd("autocmd FileType markdown,typst,html,latex Markview enableAll")
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 999,
    lazy = false,
    ---@type snacks.Config
    opts = {
      image = { enabled = true },
      explorer = { ignored = false, hidden = false },
    },
  },
}
