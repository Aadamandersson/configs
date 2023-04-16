local M = {}

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == "null-ls"
        end,
        bufnr = bufnr,
    })
end

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = " " },
        { name = "DiagnosticSignWarn", text = " " },
        { name = "DiagnosticSignHint", text = " " },
        { name = "DiagnosticSignInfo", text = " " },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- virtual_text = {
        -- 	prefix = "●",
        -- },
        virtual_text = false,
    })
end

M.on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    local keymap = vim.keymap.set

    keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    keymap("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    keymap("n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    keymap("n", "<leader>q", function()
        vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
    end, opts)

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok then
    M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M
