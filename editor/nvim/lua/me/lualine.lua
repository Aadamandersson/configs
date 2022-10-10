local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

lualine.setup {
    options = {
        icons_enabled = false,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        theme = "gruvbox"
    }
}

