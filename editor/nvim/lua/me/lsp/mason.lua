local lspconfig = require("lspconfig")

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
end

local mason_lsp_cfg_ok, mason_lsp_cfg = pcall(require, "mason-lspconfig")
if not mason_lsp_cfg_ok then
    return
end

mason.setup()
mason_lsp_cfg.setup()
mason_lsp_cfg.setup_handlers({
    function(server_name)
        local opts = {
            on_attach = require("me.lsp.handlers").on_attach,
            capabilities = require("me.lsp.handlers").capabilities,
        }
        if server_name == "lua_ls" then
            local sumneko_opts = require("me.lsp.settings.lua")
            opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
        end
        if server_name == "pyright" then
            local python_opts = require("me.lsp.settings.python")
            opts = vim.tbl_deep_extend("force", python_opts, opts)
        end
        if server_name == "rust_analyzer" then
            local rust_opts = require("me.lsp.settings.rust")
            local rust_tools_ok, rust_tools = pcall(require, "rust-tools")
            if not rust_tools_ok then
                return
            end
            rust_tools.setup(rust_opts)
            goto done
        end
        if server_name == "gopls" then
            local go_opts = require("me.lsp.settings.go")
            local go_ok, go = pcall(require, "go")
            if not go_ok then
                return
            end

            vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)
            go.setup(go_opts)
            goto done
        end
        lspconfig[server_name].setup(opts)
        ::done::
    end,
})
