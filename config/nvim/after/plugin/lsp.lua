vim.g.disable_lsp_syntax_highlight = true

local lsp = require("lspconfig")
local lspconfig_defaults = lsp.util.default_config
local root_pattern = require("lspconfig").util.root_pattern

require("mason").setup()

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  "force",
  lspconfig_defaults.capabilities,
  require("cmp_nvim_lsp").default_capabilities()
)

require("mason-lspconfig").setup({
  ensure_installed = {
    "astro",
    "bashls",
    "buf_ls",
    "clangd",
    "cssls",
    "denols",
    "docker_compose_language_service",
    "dockerls",
    "eslint",
    "gopls",
    "gradle_ls",
    "graphql",
    "hls",
    "html",
    "jsonls",
    "kotlin_language_server",
    "lua_ls",
    "nginx_language_server",
    "prismals",
    "rust_analyzer",
    "lua_ls",
    "sqlls",
    "svelte",
    "tailwindcss",
    "taplo",
    "templ",
    "terraformls",
    "ts_ls",
    "tflint",
    "vimls",
    "volar",
    "yamlls",
  },
  handlers = {
    -- Default handler
    function(server_name)
      lsp[server_name].setup({})
    end,

    -- Custom handlers
    ["eslint"] = function()
      lsp["eslint"].setup({
        root_dir = root_pattern(
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.json",
          ".eslintrc.cjs",
          ".eslintrc.yml",
          ".eslintrc.yaml"
        ),
      })
    end,

    ["jsonls"] = function()
      lsp["jsonls"].setup({
        filetypes = { "sqq", "json", "jsonc", "tfstate" },
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
    end,

    ["yamlls"] = function()
      lsp["yamlls"].setup({
        filetypes = { "yaml", "yml" },
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = "",
            },
            schemas = require("schemastore").yaml.schemas({
              extra = {
                {
                  description = "Kubernetes Deployment",
                  name = "kubernetes-deployment",
                  url = "https://kubernetesjsonschema.dev/v1.14.0/deployment-apps-v1.json",
                  fileMatch = {
                    "*deployment.yml",
                    "*deployment.yaml",
                  },
                },
                {
                  description = "Kubernetes Service",
                  name = "kubernetes-service",
                  url = "https://kubernetesjsonschema.dev/v1.10.3-standalone/service-v1.json",
                  fileMatch = {
                    "*service.yml",
                    "*service.yaml",
                  },
                },
                {
                  description = "Code Rabbit Configuration",
                  name = "coderabbit-config",
                  url = "https://coderabbit.ai/integrations/coderabbit-overrides.v2.json",
                  fileMatch = {
                    ".coderabbit.yml",
                    ".coderabbit.yaml",
                  },
                },
              },
            }),
          },
        },
      })
    end,

    ["denols"] = function()
      lsp["denols"].setup({
        root_dir = root_pattern("deno.json", "deno.jsonc"),
      })
    end,

    ["tailwindcss"] = function()
      lsp["tailwindcss"].setup({
        root_dir = root_pattern("tailwind.config.*"),
      })
    end,

    ["volar"] = function()
      lsp["volar"].setup({})
    end,

    ["ts_ls"] = function()
      local vue_typescript_plugin = require('mason-registry')
        .get_package('vue-language-server')
        :get_install_path()
        .. '/node_modules/@vue/language-server'
        .. '/node_modules/@vue/typescript-plugin'

      lsp["ts_ls"].setup({
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vue_typescript_plugin,
              languages = { "javascript", "typescript", "vue" }
            },
          },
        },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
        },
      })
    end,
  },
})

-- Setup LSP specific keybinds
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local bufnr = event.buf

    local active_clients = vim.lsp.get_active_clients()
    local client = active_clients[event.data.client_id]

    local client_exists = client ~= nil

    if client_exists then
      -- Disable LSP syntax highlighting (we're using treesitter instead)
      -- TODO: Fix this. It keeps causing problems
      -- local semantic_tokens_provider_exists = client_exists and type(client.server_capabilities) == "table" and client.server_capabilities.semanticTokensProvider ~= nil
      -- if vim.g.disable_lsp_syntax_highlight and semantic_tokens_provider_exists then
      --   client.server_capabilities.semanticTokensProvider = nil
      -- end

      -- ts_ls - denols conflict resolution
      if client.name == "denols" then
        for _, client_ in pairs(active_clients) do
          -- Stop tsserver if denols is already active
          if client_.name == "ts_ls" then
            client_.stop()
          end
        end
      elseif client.name == "ts_ls" then
        for _, client_ in pairs(active_clients) do
          -- Prevent tsserver from running if denols is already active
          if client_.name == "denols" then
            client.stop()
          end
        end
      end
    end

    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = bufnr, remap = false, desc = "[E] Show diagnostic" })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, remap = false, desc = "Go to previous [D]iagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, remap = false, desc = "Go to next [D]iagnostic" })
    -- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = bufnr, remap = false, desc = "" })
    -- vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { buffer = bufnr, remap = false, desc = "" })

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, remap = false, desc = "[G]o to [D]efinition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, remap = false, desc = "[G]o to [D]eclaration" })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, remap = false, desc = "[G]o to [I]mplementation" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, remap = false, desc = "[K] Hover" })
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr, remap = false, desc = "Go to type [D]efinition" })
    -- vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { buffer = bufnr, remap = false, desc = "Signature [H]elp (Insert mode)" })
    -- vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, remap = false, desc = "[<C-k>] Signature help (Normal mode)" })

    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr, remap = false, desc = "[W]orkspace folders: [A]dd" })
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, remap = false, desc = "[W]orkspace folders: [R]emove" })
    vim.keymap.set("n", "<leader>wl",
      function()
        vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      { buffer = bufnr, remap = false, desc = "[W]orkspace folders: [L]ist" }
    )

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, remap = false, desc = "[R]e [N]ame" })
    vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, { buffer = bufnr, remap = false, desc = "[G]o to Code [A]ctions" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, remap = false, desc = "[G]o to [R]eferences" })
  end,
})

-- Setup completion
local cmp = require("cmp")
cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    -- more sources
    { name = "nvim-lua" },
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
})

-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  -- virtual_text = {
  -- 	source = "always",
  -- },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.HINT] = "H",
      [vim.diagnostic.severity.INFO] = "I",
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Recognize json files known to actually be JSONC
vim.cmd([[
  augroup jsoncdetect
    autocmd!
    autocmd BufNewFile,BufRead .eslintrc.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead jsconfig.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead launch.json setlocal filetype=jsonc
    autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
  augroup end
]])

-- Recognize known json files with non json extensions
vim.cmd([[
  augroup jsondetect
    autocmd BufNewFile,BufRead *.tfstate setlocal filetype=json
  augroup end
]])
