return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
      legacy_commands = false,
      workspaces = {
        { name = "notes", path = "~/notes" },
      },
      notes_subdir = "inbox",
      new_notes_location = "notes_subdir",
note_id_func = function(title)
    if title ~= nil then
      return title
    end
    local suffix = ""
    for _ = 1, 4 do
      suffix = suffix .. string.char(math.random(65, 90))
    end
    return suffix
  end;
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        template = "daily.md",
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      completion = { nvim_cmp = false, blink = true, min_chars = 2 },
      picker = { name = "snacks.pick" },
      ui = { enable = false },
      attachments = { img_folder = "assets" },
      follow_url_func = function(url)
        vim.fn.jobstart({ "open", url }, { detach = true })
      end,
    },
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = { file_types = { "markdown" } },
  },
}
