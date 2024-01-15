return  {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set(
      "n",
      "<leader>e",
      function()
        vim.cmd(
          "Neotree action=focus source=filesystem position=left reveal_file="
            .. vim.fn.expand "%:p"
        )
      end
    )
   vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>')
  end
}
