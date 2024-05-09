-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        -- signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = true, -- sets vim.opt.wrap
        background = "light",
        swapfile = false,
        splitbelow = true,
        splitright = true,
        scrolloff = 4,
        -- formatoptions = vim.opt.formatoptions, ?
        clipboard = "",
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        -- dart settings
        dart_trailing_comma_indent = true,
        dart_style_guide = 2,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    -- TODO: move away from the table merge notation to avoid the conflicts and duplicate `= false` keys.
    mappings = {
      -- first key is the mode
      [""] = {
        ["gy"] = { '"+y', desc = "Copy to system clipboard" },
        ["gp"] = { '"+p', desc = "Paste from system clipboard" },
        ["gP"] = { '"+P', desc = "Paste from system clipboard" },
        ["<Leader>o"] = false,
        ["<C-s>"] = { "<cmd>w !sudo tee > /dev/null %<cr>", desc = "Force save", expr = false },
      },
      x = {
        ["<Leader>/"] = {
          "\"zy<cmd>exec 'Telescope grep_string default_text=' . escape(@z, ' ')<cr>",
          expr = false,
          desc = "Live grep selection",
        },
        ["<C-s>"] = { "<cmd>w !sudo tee > /dev/null %<cr>", desc = "Force save", expr = false },
      },
      i = {
        ["<C-s>"] = { "<cmd>w !sudo tee > /dev/null %<cr>", desc = "Force save", expr = false },
      },
      n = {
        -- second key is the lefthand side of the map
        ---------------------- files/find ----------------------
        ["<Leader>ft"] = {
          function()
            require("neo-tree.command").execute {
              toggle = true,
              reveal_force_cwd = true,
            }
          end,
          desc = "Toggle File Tree",
        },
        ["<Leader>fT"] = {
          function()
            if vim.bo.filetype == "neo-tree" then
              vim.cmd.wincmd "p"
            else
              vim.cmd.Neotree "focus"
            end
          end,
          desc = "Toggle File Tree Focus",
        },
        ["<Leader>fr"] = {
          function() require("telescope.builtin").oldfiles() end,
          desc = "Find recent files",
        },
        ["<Leader>fg"] = {
          function() require("telescope.builtin").git_files() end,
          desc = "Find files tracked in git",
        },
        ["<Leader>fs"] = {
          function() require("telescope.builtin").lsp_document_symbols() end,
          desc = "Find symbols",
        },
        ---------------------- lsp ----------------------
        ["gr"] = {
          function() require("telescope.builtin").lsp_references() end,
          desc = "References of current word",
        },
        ["gi"] = {
          function() require("telescope.builtin").lsp_implementations() end,
          desc = "Implementations of current word",
        },
        ["gt"] = {
          function() require("telescope.builtin").lsp_type_definitions() end,
          desc = "Type definition of current word",
        },
        ["gd"] = {
          function() require("telescope.builtin").lsp_definitions() end,
          desc = "Definition of current word",
        },
        ["gS"] = {
          function() require("telescope.builtin").lsp_document_symbols() end,
          desc = "Find symbols",
        },
        ["gs"] = {
          function() require("aerial").toggle() end,
          desc = "Symbols outline",
        },
        ["ga"] = {
          function() vim.lsp.buf.code_action() end,
          desc = "LSP code action",
        },
        ["<Leader>ll"] = {
          "<cmd>LspLog<cr>",
          desc = "LSP log",
        },
        ["<Leader>li"] = {
          "<cmd>LspInfo<cr>",
          desc = "LSP info",
        },
        ---------------------- errors ----------------------
        ["<Leader>e"] = { false, desc = " Errors" },
        ["<Leader>ee"] = {
          function() require("telescope.builtin").diagnostics() end,
          desc = "View and search errors",
        },
        ["<Leader>ek"] = {
          function() vim.diagnostic.goto_prev() end,
          desc = "Previous error",
        },
        ["<Leader>ej"] = {
          function() vim.diagnostic.goto_next() end,
          desc = "Next error",
        },
        ["<Leader>eo"] = {
          function() vim.diagnostic.open_float() end,
          desc = "Open error in hover window",
        },
        ---------------------- dotfiles ----------------------
        ["<Leader>."] = { false, desc = " Dotfiles" },
        ["<Leader>.n"] = {
          "<cmd>sp ~/.config/nvim/<cr>",
          desc = "Open nvim directory",
        },
        ["<Leader>.r"] = {
          "<cmd>AstroReload<cr>",
          desc = "Reload AstroNvim",
        },
        ["<Leader>.k"] = {
          "<cmd>sp ~/.config/kitty/kitty.conf<cr>",
          desc = "Open kitty config",
        },
        ["<Leader>.x"] = {
          "<cmd>sp ~/.config/xmonad/xmonad.hs<cr>",
          desc = "Open xmonad config",
        },
        ---------------------- rust  ----------------------
        ["<Leader>r"] = { false, desc = " Rust" },
        ["<Leader>rr"] = {
          function() vim.cmd.RustLsp "runnables" end,
          desc = "Find runnable",
        },
        ["<Leader>rD"] = {
          function() vim.cmd.RustLsp "debuggables" end,
          desc = "Find debuggable",
        },
        ["<Leader>rd"] = {
          function() vim.cmd.RustLsp "openDocs" end,
          desc = "Open in docs.rs",
        },
        ["<Leader>rm"] = {
          function() vim.cmd.RustLsp "expandMacro" end,
          desc = "Expand macro",
        },
        ["<Leader>rc"] = {
          function() vim.cmd.RustLsp "openCargo" end,
          desc = "Open Cargo.toml",
        },
        ["<Leader>rp"] = {
          function() vim.cmd.RustLsp "parentModule" end,
          desc = "Go to parent module",
        },
        ---------------------- mobile dev ----------------------
        -- would be nice to gate these on presence of flutter
        ["<Leader>m"] = { false, desc = " Mobile Development" },
        ["<Leader>mm"] = {
          function() require("telescope").extensions.flutter.commands() end,
          desc = "Find flutter commands",
        },
        ["<Leader>mr"] = {
          "<cmd>FlutterReload<cr>",
          desc = "Reload Flutter project",
        },
        ["<Leader>mx"] = {
          "<cmd>FlutterRun<cr>",
          desc = "Run Flutter project",
        },
        ["<Leader>md"] = {
          "<cmd>FlutterDevices<cr>",
          desc = "Choose a device",
        },
        ["<Leader>mq"] = {
          "<cmd>FlutterQuit<cr>",
          desc = "End Flutter session",
        },
        ---------------------- theme/ui ----------------------
        ["<Leader>uT"] = {
          function() require("telescope.builtin").colorscheme { enable_preview = true } end,
          desc = "Pick themes",
        },
        ["<Leader><Leader>"] = {
          function() require("notify").dismiss { silent = true } end,
          desc = "Dismiss notifications",
        },
        ["<Leader>un"] = {
          function() require("astrocore.toggles").notifications() end,
          desc = "Toggle notifications",
        },
        ["<Leader>uN"] = {
          function() require("astrocore.toggles").number() end,
          desc = "Change line numbering",
        },
        ---------------------- windows ----------------------
        ["<Leader>w"] = { false, desc = "󰖮 Windows" },
        ["<Leader>w/"] = { "<cmd>vsplit<cr>", desc = "Vertical Split (or use '|')" },
        ["<Leader>w-"] = { "<cmd>split<cr>", desc = "Horizontal Split (or use '\\')" },
        ["<Leader>w="] = { "<C-w>=", desc = "Resize windows equally" },
        ["<Leader>wc"] = { "<cmd>q<cr>", desc = "Close window (or use <spc>q)" },
        ["<Leader>wd"] = { "<cmd>q<cr>", desc = "Close window (or use <spc>q)" },
        ["<Leader>w<cr>"] = { "<C-w>o", desc = "Close other windows" },
        -- ["<Leader>wh"] = { "<C-w>h", desc = "Move to left split" },
        ["<Leader>wh"] = { function() require("smart-splits").move_cursor_left() end, desc = "Focus left split" },
        ["<Leader>wj"] = { function() require("smart-splits").move_cursor_down() end, desc = "Focus below split" },
        ["<Leader>wk"] = { function() require("smart-splits").move_cursor_up() end, desc = "Focus above split" },
        ["<Leader>wl"] = { function() require("smart-splits").move_cursor_right() end, desc = "Focus right split" },
        ["<Leader>wH"] = { function() require("smart-splits").swap_buf_left() end, desc = "Move buf to left split" },
        ["<Leader>wJ"] = { function() require("smart-splits").swap_buf_down() end, desc = "Move buf to below split" },
        ["<Leader>wK"] = { function() require("smart-splits").swap_buf_up() end, desc = "Move buf to above split" },
        ["<Leader>wL"] = { function() require("smart-splits").swap_buf_right() end, desc = "Move buf to right split" },

        ["<Leader>Wk"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
        ["<Leader>Wj"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
        ["<Leader>Wh"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
        ["<Leader>Wl"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },
        ---------------------- buffers ----------------------
        ["<Leader><tab>"] = { "<C-^>", desc = "Previous buffer" },
        ["<Leader>bc"] = { "<cmd>bdelete<cr>", desc = "Close buffer (or use <spc>c)" },
        ["<Leader>bd"] = { "<cmd>bdelete<cr>", desc = "Close buffer (or use <spc>c)" },
        ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<Leader>bD"] = {
          function()
            require("astroui.status").heirline.buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        ---------------------- utils ----------------------
        ["<Leader>/"] = {
          function() require("telescope.builtin").live_grep() end,
          expr = false,
          desc = "Live grep",
        },
        ["<Leader>;"] = {
          function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Toggle comment line",
        },
        ["<Leader>?"] = { function() require("telescope.builtin").keymaps() end, desc = "Keymaps" },
        ["<Leader>s"] = { "<cmd>w<cr>", desc = "Save buffer" },
        ["<Leader>S"] = { "<cmd>wa<cr>", desc = "Save all buffers" },
        ["<C-s>"] = { "<cmd>w !sudo tee > /dev/null %<cr>", desc = "Force save", expr = false },
        ["<cr>"] = { "o<esc>k", desc = "Insert line below" },
        ["<s-cr>"] = { "O<esc>j", desc = "Insert line above" },
        ["<Leader>pr"] = { "<cmd>AstroReload<cr>", desc = "Reload AstroNvim" },
        ["gw"] = {
          function()
            local save_cursor = vim.fn.getpos "."
            vim.cmd [[%s/\s\+$//e]]
            vim.fn.setpos(".", save_cursor)
          end,
          desc = "Delete trailing whitespace",
        },
      },
      v = {
        ["<Leader>;"] = {
          "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
          desc = "Toggle comment for selection",
        },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
