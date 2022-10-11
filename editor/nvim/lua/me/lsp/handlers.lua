local M = {}

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name == "sumneko_lua" or client.name == "rust_analyzer"
        end,
        bufnr = bufnr,
    })
end

M.setup = function()
    local cfg = {
        virtual_text = false,
    }

    vim.diagnostic.config(cfg)
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
    keymap("n", "[g", '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)

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

return M
