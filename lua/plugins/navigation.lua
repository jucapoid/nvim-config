return {

  ------------------------------------------------------------------------------
  -- Telescope
  ------------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },

    config = function()
      local telescope = require("telescope")

      telescope.setup({})

      pcall(telescope.load_extension, "fzf")
    end,
  },

  ------------------------------------------------------------------------------
  -- Oil
  ------------------------------------------------------------------------------
  {
    "stevearc/oil.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("oil").setup()

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", {
        desc = "Open parent directory",
      })
    end,
  },

  ------------------------------------------------------------------------------
  -- Flash
  ------------------------------------------------------------------------------
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        function()
          require("flash").jump()
        end,
        desc = "Flash",
        mode = { "n", "x", "o" },
      },
    },
  },
}
