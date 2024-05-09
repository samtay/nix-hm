-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  -- import/override with your plugins folder
  { import = "astrocommunity.colorscheme.gruvbox-nvim" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.dart" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.haskell" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.nix" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  { import = "astrocommunity.completion.copilot-lua" },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        keymap = {
          accept = "<C-CR>",
          accept_word = false,
          accept_line = false,
          next = "<C-.>",
          prev = "<C-,>",
          dismiss = "<C/>",
        },
      },
    },
  },
  {
    "gruvbox.nvim",
    opts = {
      italic = {
        comments = true,
      },
    },
  },
  -- {
  --   "akinsho/flutter-tools.nvim",
  --   opts = function()
  --     local lsp = require("astronvim.utils.lsp").config "dartls"
  --     lsp.settings.analysisExcludedFolders = { "/opt/flutter/bin/cache/pkg/" }
  --     return {
  --       lsp = lsp,
  --       debugger = { enabled = true },
  --     }
  --   end,
  -- },
}
