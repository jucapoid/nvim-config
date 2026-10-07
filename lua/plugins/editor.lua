return {
  ------------------------------------------------------------------------------
  -- Theme
  ------------------------------------------------------------------------------
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme(tokyonight)
    end,
  },

  ------------------------------------------------------------------------------
  -- Treesitter
  ------------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local languages = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "php",
        "python",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "blade",
      }

      -- Rewrite on the main branch: no nvim-treesitter.configs module.
      require("nvim-treesitter").install(languages)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  ------------------------------------------------------------------------------
  -- Mini.nvim
  ------------------------------------------------------------------------------
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
        require("mini.ai").setup()

        require("mini.surround").setup()

        require("mini.comment").setup()

        require("mini.pairs").setup({modes = {insert = true, command = false, terminal = false,},})
    end,
  },
}
