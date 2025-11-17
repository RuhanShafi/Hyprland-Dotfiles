return {

  -- NEOTREE MAIN PLUGIN
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",

      -- file operations support
      "antosha417/nvim-lsp-file-operations",

      -- window picker support
      "s1n7ax/nvim-window-picker",
    },

    config = function()
      -- WINDOW PICKER SETUP
      require("window-picker").setup({
        filter_rules = {
          visible = true,
          show_hidden_count = true,
          include_current_win = false,
          hide_dotfiles = false,
          autoselect_one = true,

          bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            buftype = { "terminal", "quickfix" },
          },
        },
      })

      -- FILE OPERATIONS SETUP
      require("lsp-file-operations").setup()

      -- NEOTREE SETUP
      require("neo-tree").setup({
        close_if_last_window = true,
        enable_git_status = true,
        enable_diagnostics = true,

        filesystem = {
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = "open_default",
        },

        window = {
          width = 35,
        },
      })

      -- KEYMAPS
      local keymap = vim.keymap

      -- Toggle Neo-tree
      keymap.set("n", "<leader>ee", "<cmd>Neotree toggle<CR>",
        { desc = "Toggle file explorer" })

      -- Reveal current file
      keymap.set("n", "<leader>ef", "<cmd>Neotree reveal<CR>",
        { desc = "Toggle file explorer on current file" })

      -- Collapse (close + reopen trick)
      keymap.set("n", "<leader>ec", "<cmd>Neotree close<CR><cmd>Neotree<CR>",
        { desc = "Collapse file explorer" })

      -- Refresh filesystem
      keymap.set("n", "<leader>er", "<cmd>Neotree source=filesystem refresh<CR>",
        { desc = "Refresh file explorer" })
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
  {
    "s1n7ax/nvim-window-picker",
    version = "2.*",
    config = function()
      require("window-picker").setup({
        filter_rules = {
          include_current_win = false,
          autoselect_one = true,

          bo = {
            filetype = { "neo-tree", "neo-tree-popup", "notify" },
            buftype = { "terminal", "quickfix" },
          },
        },
      })
    end,
  },
}

