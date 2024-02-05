return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
    end
  },
  {
    "catppuccin/nvim",
    name = "catpuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end
  }
}
