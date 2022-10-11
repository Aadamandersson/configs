local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

local formatting = null_ls.builtins.formatting

null_ls.setup({
    sources = {
        formatting.stylua,
        formatting.rustfmt,
    },
})
