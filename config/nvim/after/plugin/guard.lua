local ft = require("guard.filetype")

local function prettier_fmt(buf, _, acc)
  local co = assert(coroutine.running())
  local handle = vim.system(
    { "prettierd", vim.api.nvim_buf_get_name(buf) },
    { stdin = true },
    function(result)
      if result.code ~= 0 then
        -- "returns" the error
        coroutine.resume(co, result)
      else
        -- "returns" the result
        coroutine.resume(co, result.stdout)
      end
    end
  )

  handle:write(acc)
  handle:write(nil)
  return coroutine.yield()
end

local jsonlint = {
  cmd = "npx",
  fname = true,
  args = { "--quiet" },
  stdin = true,
}

ft("lua"):fmt("lsp"):append("stylua"):lint("selene")

-- TODO: Fix comma spearation in guard.nvim
-- ft("javascript,typescript,javascriptreact,typescriptreact"):fmt({ fn = prettier_fmt }):lint("lsp")

ft("javascript"):fmt({ fn = prettier_fmt }):lint("lsp")
ft("javascriptreact"):fmt({ fn = prettier_fmt }):lint("lsp")
ft("javascript.jsx"):fmt({ fn = prettier_fmt }):lint("lsp")
ft("typescript"):fmt({ fn = prettier_fmt }):lint("lsp")
ft("typescriptreact"):fmt({ fn = prettier_fmt }):lint("lsp")
ft("typescript.tsx"):fmt({ fn = prettier_fmt }):lint("lsp")

ft("vue"):fmt({ fn = prettier_fmt })

ft("json"):fmt({ fn = prettier_fmt }):lint(jsonlint)

-- TODO: Setup cbfmt for md files
