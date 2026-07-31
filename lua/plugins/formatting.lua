return {
  {
    "stevearc/conform.nvim",

    event = { "BufWritePre" },

    opts = {
      notify_on_error = true,

      format_on_save = function(bufnr)
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end,

      formatters_by_ft = {
        lua = { "stylua" },

        c = { "clang_format" },

        cpp = { "clang_format" },

        php = { "pint" },

        javascript = { "prettierd", "prettier" },

        typescript = { "prettierd", "prettier" },

        html = { "prettierd", "prettier" },

        css = { "prettierd", "prettier" },

        json = { "prettierd", "prettier" },

        yaml = { "prettierd", "prettier" },

        markdown = { "prettierd", "prettier" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",

    event = {
      "BufReadPre",
      "BufNewFile",
    },

    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        lua = { "selene" },

        c = { "clangtidy" },

        cpp = { "clangtidy" },

        php = { "phpstan" },

        javascript = { "eslint_d" },

        typescript = { "eslint_d" },
      }

      vim.api.nvim_create_autocmd({
        "BufWritePost",
        "InsertLeave",
    }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
