local opts = {
    tabstop = 2,
    shiftwidth = 2,
    softtabstop = 2,
}

for k, v in pairs(opts) do
    vim.opt[k] = v
end
