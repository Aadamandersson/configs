local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = " "

keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("n", "<leader><leader>", "<c-^>", opts)
keymap("n", "<C-h>", ":nohlsearch<cr>", opts)

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
