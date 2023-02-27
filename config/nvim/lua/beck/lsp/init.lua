-- Mappings. (Copied from the nvim-lspconfig docs)
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
print("Old config caled")
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

  -- tsserver - denols conflict resolution
  local active_clients = vim.lsp.get_active_clients()
  if client.name == "denols" then
    for _, client_ in pairs(active_clients) do
      -- Stop tsserver if denols is already active
      if client_.name == "tsserver" then
        client_.stop()
      end
    end
  elseif client.name == "tsserver" then
    for _, client_ in pairs(active_clients) do
      -- Prevent tsserver from running if denols is already active
      if client_.name == "denols" then
        client.stop()
      end
    end
  end
end

-- Custom config
local lspconfig = require("lspconfig")

-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local configs = require("lspconfig.configs")
local volar_script_path = os.getenv("HOME")
    .. "/.local/share/nvim/mason/packages/vue-language-server/node_modules/@volar/vue-language-server/out/index.js"
local tslib_path = os.getenv("HOME")
    .. "/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib/tsserverlibrary.js"

-- Allows searching for patterns in parent folders (used for tsserver and denols)
local root_pattern = lspconfig.util.root_pattern

lspconfig.astro.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.cssls.setup({
  capabilities = capabilities,
})
lspconfig.dartls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.g.markdown_fenced_languages = {
  "ts=typescript",
}
lspconfig.denols.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  root_dir = root_pattern("deno.json", "deno.jsonc"),
})
lspconfig.dockerls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "go" },
})
lspconfig.graphql.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "gql", "graphql" },
})
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
lspconfig.svelte.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  -- root_dir = root_pattern("package.json"),
})
lspconfig.vimls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
configs.volar = {
  default_config = {
    cmd = { "node", volar_script_path, "--stdio" },
    filetypes = { "vue" },
    root_dir = root_pattern("package.json", "vue.config.js", "nuxt.config.js"),
    init_options = {
      typescript = {
        serverPath = tslib_path,
      },
      languageFeatures = {
        references = true,
        definition = true,
        typeDefinition = true,
        callHierarchy = true,
        hover = true,
        rename = true,
        renameFileRefactoring = true,
        signatureHelp = true,
        codeAction = true,
        completion = {
          defaultTagNameCase = "both",
          defaultAttrNameCase = "kebabCase",
          getDocumentNameCasesRequest = false,
          getDocumentSelectionRequest = false,
        },
        schemaRequestService = true,
        documentHighlight = true,
        documentLink = true,
        codeLens = { showReferencesNotification = true },
        semanticTokens = true,
        diagnostics = true,
      },
    },
    documentFeatures = {
      selectionRange = false,
      foldingRange = false,
      linkedEditingRange = true,
      documentSymbol = true,
      documentColor = true,
      documentFormatting = {
        defaultPrintWidth = 100,
        getDocumentPrintWidthRequest = true,
      },
    },
    settings = {
      ["volar-api"] = {
        trace = {
          server = "off",
        },
      },
      ["volar-document"] = {
        trace = {
          server = "off",
        },
      },
      ["volar-html"] = {
        trace = {
          server = "off",
        },
      },
      volar = {
        codeLens = {
          references = true,
          pugTools = true,
          scriptSetupTools = true,
        },
        tagNameCase = "both",
        attrNameCase = "kebab",
        formatting = {
          printWidth = 100,
        },
        autoCompleteRefs = true,
        preferredTagNameCase = "auto",
        preferredAttrNameCase = "auto-kebab",
      },
    },
  },
}
lspconfig.volar.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    volar = { autoCompleteRefs = true },
  },
})
-- require('beck.lsp.volar')
