return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      hightlight = { enable = true },
      indent = { enable = true },
      autopairs = { enable = true },
      autotag = { enable = true }
    })
    require 'nvim-treesitter.install'.compilers = { "clang" }
  end
}
