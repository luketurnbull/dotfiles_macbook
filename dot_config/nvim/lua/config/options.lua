vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.root_spec = { ".git", "cwd" }

if vim.fn.has("win32") == 1 then
  LazyVim.terminal.setup("pwsh")
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      local ok, install = pcall(require, "nvim-treesitter.install")
      if ok then install.compilers = { "zig" } end
    end,
  })
end
