return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,

  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },

    -- MAIN MAPPINGS
    defaults = {
      mode = "n",
      ["<leader>"] = {

        -- FILE EXPLORER GROUP
        e = {
          name = "File Tree",
          e = { "<cmd>Neotree toggle<CR>", "Toggle file explorer" },
          f = { "<cmd>Neotree reveal<CR>", "Toggle file explorer on current file" },
          c = { "<cmd>Neotree close<CR><cmd>Neotree<CR>", "Collapse file explorer" },
          r = { "<cmd>Neotree source=filesystem refresh<CR>", "Refresh file explorer" },
        },
      },
    },
  },
}

