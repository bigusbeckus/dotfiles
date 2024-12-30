return {
  "iamcco/markdown-preview.nvim", -- Markdown preview
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  config = function()
    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_theme = "dark"

    local open_md_preview = function()
      local current_buffer = vim.api.nvim_get_current_buf()
      if vim.filetype.match({ buf = current_buffer }) == "markdown" then
        vim.cmd([[MarkdownPreviewToggle]])
      end
    end
    vim.keymap.set("n", "<leader>md", open_md_preview, { noremap = true })
  end,
}
