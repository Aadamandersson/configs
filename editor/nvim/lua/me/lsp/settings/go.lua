return {
    lsp_cfg = {
        on_attach = require "me.lsp.handlers".on_attach,
        capabilities = require "me.lsp.handlers".capabilities,
    },
    lsp_inlay_hints = {
        enable = true,
        show_parameter_hints = false,
        other_hints_prefix = "=>",
    },
    lsp_keymaps = false,
    lsp_codelens = false,
}
