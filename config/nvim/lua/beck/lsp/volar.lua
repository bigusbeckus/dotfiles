-- Vue Language Server (Volar) configuration

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- local path = nvim_lsp.util.path
-- local volar_path = path.join(vim.fn.stdpath 'data', 'lsp_servers', 'volar', 'node_modules')
-- local globa_ts_server_path = path.join(volar_path, 'typescript', 'lib')
local configs = lspconfig.configs
local util = lspconfig.util
local tslib_path = os.getenv('HOME') ..
    '/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/lib/tsserverlibrary.js'

configs.volar = {
  default_config = {
    filetypes = { 'vue' },
    root_dir = util.root_pattern('package.json', 'vue.config.js'),
    init_options = {
      typescript = {
        serverPath = tslib_path,
      }
    }
  }
}
lspconfig.volar.setup {
  capabilities = capabilities,
  -- filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
  -- on_attach = on_attach,
  --  init_options = {
  --    typescript = {
  --      tsdk = globa_ts_server_path,
  --    }
  --  },
  settings = {
    volar = { autoCompleteRefs = true },
  },
}
