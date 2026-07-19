-- Return Zellij to Normal mode when leaving Neovim
vim.api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = "silent !zellij action switch-mode normal",
})

-- Open .excalidraw files in the Excalidraw PWA instead of loading them as buffers
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.excalidraw",
  callback = function(args)
    vim.fn.jobstart({ "open", args.file }, { detach = true })
    vim.schedule(function()
      pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
    end)
  end,
})

-- Override <CR> in notes markdown buffers: if the link under cursor points
-- to a .excalidraw file, open it in the PWA. Otherwise defer to obsidian.nvim.
local function follow_link_excalidraw_aware()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1
  for s, target, e in line:gmatch("()%[[^%]]*%]%(([^)]+)%)()") do
    if col >= s and col < e and target:match("%.excalidraw$") then
      local path = vim.fn.expand(target)
      if path:sub(1, 1) ~= "/" then
        local cands = {
          vim.fn.expand("%:p:h") .. "/" .. path,
          vim.fn.expand("~/notes/excalidraw/") .. path,
        }
        for _, c in ipairs(cands) do
          if vim.fn.filereadable(c) == 1 then
            path = c
            break
          end
        end
      end
      vim.fn.jobstart({ "open", path }, { detach = true })
      return
    end
  end
  vim.cmd("Obsidian follow_link")
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    local bufpath = vim.api.nvim_buf_get_name(args.buf)
    if not bufpath:find(vim.fn.expand("~/notes"), 1, true) then
      return
    end
    vim.schedule(function()
      vim.keymap.set("n", "<CR>", follow_link_excalidraw_aware, {
        buffer = args.buf,
        desc = "Follow link (excalidraw aware)",
      })
    end)
  end,
})

-- Auto-reload files modified by external processes (e.g. Claude Code in adjacent pane)
vim.opt.autoread = true

local timer = vim.uv.new_timer()
timer:start(0, 1000, vim.schedule_wrap(function()
  vim.cmd("silent! checktime")
end))
