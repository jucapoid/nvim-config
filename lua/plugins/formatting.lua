local empty_function_body = require("php.empty_function_body")

return {
  {
    "stevearc/conform.nvim",

    event = { "BufWritePre" },

    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({
            async = true,
            lsp_format = vim.bo.filetype == "php" and "never" or "fallback",
          }, function(err)
            if err then
              return
            end
            local mode = vim.api.nvim_get_mode().mode
            if vim.startswith(string.lower(mode), "v") then
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
            end
          end)
        end,
        mode = { "n", "x" },
        desc = "Format selection or file",
      },
    },

    opts = {
      notify_on_error = true,

      format_on_save = function(bufnr)
        local opts = {
          timeout_ms = 500,
          lsp_format = "fallback",
        }

        if vim.bo[bufnr].filetype == "php" then
          opts.lsp_format = "never"
        end

        return opts
      end,

      formatters = {
        pint = {
          cwd = function(_, ctx)
            local marker = vim.fs.find({ "pint.json", "composer.json" }, {
              path = ctx.dirname,
              upward = true,
            })[1]

            if not marker then
              return nil
            end

            return vim.fs.dirname(marker)
          end,
          command = function(ctx)
            local marker = vim.fs.find("composer.json", {
              path = ctx.dirname,
              upward = true,
            })[1]

            if marker then
              local pint = vim.fs.joinpath(vim.fs.dirname(marker), "vendor/bin/pint")
              if vim.fn.executable(pint) == 1 then
                return pint
              end
            end

            return "pint"
          end,
        },
        php_empty_function_body = {
          meta = {
            description = "Empty PHP function bodies: `{}` on the line after the signature (Pint alone cannot keep this).",
          },
          format = function(_, _ctx, lines, callback)
            callback(nil, empty_function_body.collapse(lines))
          end,
        },
      },

      formatters_by_ft = {
        lua = { "stylua" },

        c = { "clang_format" },

        cpp = { "clang_format" },

        php = { "pint", "php_empty_function_body" },

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
