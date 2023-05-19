return {
    lsp_cfg = {
        on_attach = require("me.lsp.handlers").on_attach,
        capabilities = require("me.lsp.handlers").capabilities,
        settings = {
            gopls = {
                usePlaceholders = false,
            },
        },
    },
    lsp_inlay_hints = {
        enable = true,
        show_parameter_hints = false,
        other_hints_prefix = "=>",
    },
    goimport = "goimports",
    lsp_keymaps = false,
    lsp_codelens = false,
    dap_debug = true,
    dap_debug_gui = false,
    dap_debug_map = false,
}
