return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    plugins = {
      marks = true,       -- shows a list of your marks on ' and `
      registers = true,   -- shows your registers on " in normal or <C-r> in insert mode
      spelling = {
        enabled = true,   -- enable spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = false, -- adds help for operators like d, y, ...
        motions = false,   -- adds help for motions
        text_objects = false, -- help for text objects triggered after entering an operator
        windows = true,    -- default bindings on <c-w>
        nav = true,        -- misc bindings to work with windows
        z = true,          -- bindings for folds, spelling and others prefixed with z
        g = true,          -- bindings for prefixed with g
      },
    },
    defaults = {
      mode = "n", -- Normal mode
      ["<leader>"] = {
        e = { 
          name = "File Tree", -- Creates a group label for <leader>e
          e = { "<cmd>NvimTreeToggle<CR>", "Toggle file explorer" },
          f = { "<cmd>NvimTreeFindFileToggle<CR>", "Toggle file explorer on current file" },
          c = { "<cmd>NvimTreeCollapse<CR>", "Collapse file explorer" },
          r = { "<cmd>NvimTreeRefresh<CR>", "Refresh file explorer" },
        },
      },
    },
  },
}

