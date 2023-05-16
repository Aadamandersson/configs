local extension_path = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.9.1/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path
    .. "lldb/lib/liblldb"
    .. (vim.loop.os_uname().sysname == "Linux" and ".so" or ".dylib")

return {
    server = {
        on_attach = require("me.lsp.handlers").on_attach,
        capabilities = require("me.lsp.handlers").capabilities,
    },
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
        },
    },
    tools = {
        inlay_hints = {
            show_parameter_hints = false,
        },
    },
    dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    },
}
