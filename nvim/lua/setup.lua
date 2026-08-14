vim.pack.add {
  "https://github.com/tpope/vim-sleuth", -- todo: not sure if i need this
  "https://github.com/savq/melange-nvim",
  "https://github.com/rafamadriz/friendly-snippets",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range "1.*" },
  { src = "https://github.com/nvim-mini/mini.icons", version = "stable" },
  { src = "https://github.com/nvim-mini/mini.surround", version = "stable" },
  { src = "https://github.com/stevearc/quicker.nvim" },
  "https://github.com/stevearc/oil.nvim",
  "https://github.com/mrjones2014/smart-splits.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  { src = "https://github.com/theprimeagen/harpoon", version = "harpoon2" }, -- todo: remove probably
}

vim.cmd.packadd "nvim.undotree"
vim.keymap.set("n", "<leader>u", require("undotree").open)

require "oil".setup {
  columns = { "icon" },
  skip_confirm_for_simple_edits = true,
  view_options = { show_hidden = true },
  delete_to_trash = true,
  keymaps = {
    ["<C-s>"] = false,
    ["<C-e>"] = "actions.select_vsplit",
    ["<C-h>"] = false,
    ["<C-p>"] = false,
    ["<C-t>"] = "actions.preview",
    ["."] = "actions.toggle_hidden",
  },
  float = {
    border = "rounded",
    padding = 5,
    max_width = 150,
    win_options = { winblend = 0 },
  },
}

require "blink-cmp".setup {
  signature = { enabled = true },
  cmdline = {
    keymap = {
      ["<Tab>"] = {},
    },
  },
  completion = {
    documentation = { auto_show = true },
    accept = { auto_brackets = { enabled = false } },
    menu = {
      auto_show = function(ctx)
        return ctx.mode ~= "cmdline" and vim.o.ft ~= "rust"
      end,
      draw = {
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", gap = 1, "kind" } },
      },
    },
  },
}

vim.keymap.set("n", "<C-n>", function()
  require "harpoon".ui:toggle_quick_menu(require "harpoon":list(), {
    border = "rounded",
    ui_width_ratio = 0.4,
  })
end)

-- todo :h nvim_replace_termcodes()
vim.keymap.set("n", "<leader>a", function() require "harpoon":list():add() end)
vim.keymap.set("n", "<C-h>", function() require "harpoon":list():select(1) end)
vim.keymap.set("n", "<C-j>", function() require "harpoon":list():select(2) end)
vim.keymap.set("n", "<C-k>", function() require "harpoon":list():select(3) end)
vim.keymap.set("n", "<C-l>", function() require "harpoon":list():select(4) end)
vim.keymap.set("n", "<C-p>", function() require "harpoon":list():select(5) end)

vim.keymap.set("n", "-", vim.cmd.Oil)
vim.keymap.set("n", "<leader>of", function() require "oil".toggle_float() end)
vim.keymap.set("n", "<leader>o~", function() require "oil".toggle_float "~" end)

vim.keymap.set("n", "<leader>q", function()
  require("quicker").toggle { focus = true, height = 8 }
end)
vim.keymap.set("n", "<leader>l", function()
  require("quicker").toggle { focus = true, height = 8, loclist = true }
end)
vim.keymap.set("n", ">", function()
  require("quicker").toggle_expand { before = 3, after = 3, add_to_existing = true }
end)

vim.keymap.set("n", "<A-H>", function() require "smart-splits".resize_left() end)
vim.keymap.set("n", "<A-J>", function() require "smart-splits".resize_down() end)
vim.keymap.set("n", "<A-K>", function() require "smart-splits".resize_up() end)
vim.keymap.set("n", "<A-L>", function() require "smart-splits".resize_right() end)
vim.keymap.set("n", "<A-h>", function() require "smart-splits".move_cursor_left() end)
vim.keymap.set("n", "<A-j>", function() require "smart-splits".move_cursor_down() end)
vim.keymap.set("n", "<A-k>", function() require "smart-splits".move_cursor_up() end)
vim.keymap.set("n", "<A-l>", function() require "smart-splits".move_cursor_right() end)
vim.keymap.set("n", "<A-/>", function() require "smart-splits".move_cursor_previous() end)
