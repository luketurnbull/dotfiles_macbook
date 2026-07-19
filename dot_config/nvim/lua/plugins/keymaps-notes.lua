return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>n", false },
      { "<leader>N", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>n", group = "notes" },
        { "<leader>nx", group = "excalidraw" },
      },
    },
    keys = {
      { "<leader>nn", "<cmd>Obsidian new<cr>", desc = "New note" },
      { "<leader>nt", "<cmd>Obsidian today<cr>", desc = "Today (daily note)" },
      { "<leader>ny", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday" },
      {
        "<leader>nf",
        function()
          require("snacks").picker.files({ cwd = vim.fn.expand("~/notes") })
        end,
        desc = "Find note",
      },
      {
        "<leader>ng",
        function()
          require("snacks").picker.grep({ cwd = vim.fn.expand("~/notes") })
        end,
        desc = "Grep notes",
      },
      { "<leader>nb", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
      { "<leader>nT", "<cmd>Obsidian tags<cr>", desc = "Tags" },
      { "<leader>no", "<cmd>Obsidian follow_link<cr>", desc = "Follow link" },
      { "<leader>nr", "<cmd>Obsidian rename<cr>", desc = "Rename note" },
      { "<leader>nxn", "<cmd>Excalidraw create<cr>", desc = "New drawing (+ link)" },
      { "<leader>nxo", "<cmd>Excalidraw open<cr>", desc = "Open drawing under cursor" },
      { "<leader>nxf", "<cmd>Excalidraw find_scenes<cr>", desc = "Find all drawings" },
      { "<leader>nxb", "<cmd>Excalidraw find_scenes_in_buffer<cr>", desc = "Drawings in buffer" },
      { "<leader>nxt", "<cmd>Excalidraw create_from_template<cr>", desc = "New drawing from template" },
      { "<leader>np", "<cmd>MarkdownPreview<cr>", desc = "Markdown preview (browser)" },
    },
  },
}
