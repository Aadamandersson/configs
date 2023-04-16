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
}
