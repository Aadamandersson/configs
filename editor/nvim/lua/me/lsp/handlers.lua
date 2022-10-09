local M = {}

M.setup = function ()
    local cfg = {
        virtual_text = false,
    }

    vim.diagnostic.config(cfg)
end

M.on_attach = function(_, bufnr)
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
	keymap("n", "]g", '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

return M
