return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",

  opts = function()
    -- ICONS (Nerd Fonts)
    local icons = {
      bug = "",
      hint = "󰌶",
      info = "",
      warning = "",
      added = "",
      modified = "",
      deleted = "",
      git = "",
      lsp = "",
    }

    -- DIAGNOSTICS COMPONENT
    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn", "info", "hint" },
      symbols = {
        error = icons.bug .. " ",
        warn = icons.warning .. " ",
        info = icons.info .. " ",
        hint = icons.hint .. " ",
      },
      icon = icons.lsp .. " ",
      colored = true,
      update_in_insert = false,
      always_visible = false,
    }

    -- DIFF COMPONENT (linked to GitSigns)
    local diff = {
      "diff",
      symbols = {
        added = icons.added .. " ",
        modified = icons.modified .. " ",
        removed = icons.deleted .. " ",
      },
      icon = icons.git,
      colored = true,
      always_visible = false,
      source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end,
    }

    return {
      options = {
        theme = "auto",
        icons_enabled = true,
        globalstatus = true,

        -- Nice rounded separators
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },

        disabled_filetypes = {
          statusline = { "dashboard", "lazy", "alpha" },
        },
      },

      sections = {
        lualine_a = {
          { "mode" },

          -- Macro recording indicator (same behavior as your original config)
          {
            "macro-recording",
            fmt = function()
              local reg = vim.fn.reg_recording()
              if reg == "" then
                return ""
              else
                return "Recording @" .. reg
              end
            end,
          },
        },

        lualine_b = {
          "branch",
          diff,
          diagnostics,
        },

        lualine_c = {
          "filename",
          "searchcount",
        },

        lualine_x = {
          "fileformat",
          "filetype",
        },

        lualine_y = {
          "progress",
        },

        lualine_z = {
          "location",
        },
      },
    }
  end,

  config = function(_, opts)
    local lualine = require("lualine")
    lualine.setup(opts)

    -- Auto-refresh when entering macro-recording mode
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        lualine.refresh({ place = { "lualine_a" } })
      end,
    })
  end,
}

