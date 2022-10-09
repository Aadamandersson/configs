local lspconfig = require("lspconfig")
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
    return
end

local mason_lsp_ok, mason_lsp_cfg = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then
    return
end

mason.setup()
mason_lsp_cfg.setup()

mason_lsp_cfg.setup_handlers {
    function(server_name)
         local opts = {
             on_attach = require("me.lsp.handlers").on_attach,
             capabilities = require("me.lsp.handlers").capabilities
         }
         if server_name == "sumneko_lua" then
            local sumneko_opts = require("me.lsp.settings.sumneko_lua")
            opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
            --sumneko_opts["on_attach"] = opts.on_attach
            --sumneko_opts["capabilities"] = opts.capabilities
            --lspconfig[server_name].setup(sumneko_opts)
         end
         lspconfig[server_name].setup(opts)
    end
    -- function(server_name)
    --     local opts = {
    --         on_attach = require("me.lsp.handlers").on_attach,
    --         capabilities = require("me.lsp.handlers").capabilities
    --     }
    --     local has_cust_opts, cust_opts = pcall(require, "me.lsp.settings." .. server_name)
    --     if has_cust_opts then
    --         opts = vim.tbl_deep_extend("force", opts, cust_opts)
    --     end
    --     lspconfig[server_name].setup(opts)
    -- end,
    -- ["sumneko_lua"] = function()
    --     local opts = {
    --         on_attach = require("me.lsp.handlers").on_attach,
    --         capabilities = require("me.lsp.handlers").capabilities
    --     }
    --     local has_opts, cust_opts = pcall(require, "me.lsp.settings.sumneko_lua")
    --     if has_opts then
    --         opts = vim.tbl_deep_extend("force", opts, cust_opts)
    --     end
    --     lspconfig.sumneko_lua.setup(opts)
    -- end,
}


