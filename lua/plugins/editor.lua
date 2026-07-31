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
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({
        ensure_installed = {
          bash,
          c,
          html,
          javascript,
          json,
          lua,
          markdown,
          php,
          python,
          tsx,
          typescript,
          vim,
          yaml,
        },

        highlight = {
          enable = true,
        },

        indent = {
          enable = true,
        },
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
