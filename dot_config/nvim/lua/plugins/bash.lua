return {
  { "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "bash" } } },
  { "neovim/nvim-lspconfig",
    opts = { servers = { bashls = {} } } },
  { "stevearc/conform.nvim",
    opts = { formatters_by_ft = {
      sh = { "shfmt" }, bash = { "shfmt" } } } },
  { "mason-org/mason.nvim",
    opts = { ensure_installed = {
      "bash-language-server", "shfmt", "shellcheck" } } },
}
