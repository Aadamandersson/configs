vim.g.mapleader = " "

vim.keymap.set("n", "<leader><leader>", "<c-^>")

vim.keymap.set({ "n", "v" }, "<C-h>", "<cmd>nohlsearch<cr>")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set('n', '<leader>o', ':e <C-R>=expand("%:p:h") . "/" <cr>')
