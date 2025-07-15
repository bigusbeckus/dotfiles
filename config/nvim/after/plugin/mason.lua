-- Auto-install packages common across most projects/machines
local common_packages = {
  "jsonlint",
  "markdownlint",
  "prettier",
  "selene",
  "stylua"
}

local mason_registry = require("mason-registry")

for _, mason_package in pairs(common_packages) do
  if not mason_registry.is_installed(mason_package) then
    mason_registry.get_package(mason_package):install()
  end
end
