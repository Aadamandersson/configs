local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader><leader>", "<c-^>", opts)
keymap("n", "<C-h>", ":nohlsearch<cr>", opts)
keymap("n", "<leader>y", '"+y', opts)

keymap("", "<space>", "<nop>", opts)
keymap("", "<up>", "<nop>", opts)
keymap("", "<down>", "<nop>", opts)
keymap("", "<left>", "<nop>", opts)
keymap("", "<right>", "<nop>", opts)
keymap("", "<leader>co", ":copen<CR>", opts)
keymap("", "<leader>cc", ":cclose<CR>", opts)
keymap("x", "<leader>p", '"_dP', opts)

-- `nvim_set_keymap` does not accept lua functions, so we use `vim.keymap.set` instead.
vim.keymap.set("n", "<leader>e", function()
    return ":e " .. vim.fn.expand("%:p:h") .. "/"
end, { expr = true })

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

vim.keymap.set("n", "<leader>dt", function()
    dap.toggle_breakpoint()
end)

vim.keymap.set("n", "<leader>dk", function()
    dap.continue()
end)

vim.keymap.set("n", "<leader>dl", function()
    dap.run_last()
end)
