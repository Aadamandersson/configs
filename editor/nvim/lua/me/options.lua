local opts = {
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 4,
    cmdheight = 2,
    scrolloff = 8,
    updatetime = 300,
    showmatch = true,
    expandtab = true,
    number = true,
    relativenumber = true,
    undofile = true,
    splitright = true,
    splitbelow = true,
    wrap = false,
    signcolumn = "yes",
}

for k, v in pairs(opts) do
    vim.opt[k] = v
end
