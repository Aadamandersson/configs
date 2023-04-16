local ok, configs = pcall(require, "nvim-treesitter.configs")
if not ok then
    return
end

configs.setup({
    ensure_installed = { "lua", "rust", "go", "ocaml" },
    auto_install = false,
    highlight = {
        enable = true,
    },
})
