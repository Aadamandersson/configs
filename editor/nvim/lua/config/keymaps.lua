vim.keymap.set("n", "<leader>fN", ':e <C-R>=expand("%:p:h") . "/" <cr>', {
  desc = "New file (cwd)",
})

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v", "i" }, "<up>", "<nop>")
vim.keymap.set({ "n", "v", "i" }, "<down>", "<nop>")
vim.keymap.set({ "n", "v", "i" }, "<left>", "<nop>")
vim.keymap.set({ "n", "v", "i" }, "<right>", "<nop>")
