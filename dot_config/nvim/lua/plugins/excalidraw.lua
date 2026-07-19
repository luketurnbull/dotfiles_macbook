return {
  {
    "marcocofano/excalidraw.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    ft = "markdown",
    opts = {
      storage_dir = vim.fn.expand("~/notes/excalidraw"),
      templates_dir = vim.fn.expand("~/notes/excalidraw/templates"),
      open_on_create = true,
      relative_path = false,
    },
  },
}
