local ok, signature = pcall(require, "lsp_signature")
if not ok then
	return
end

local cfg = {
	hint_prefix = "",
}

signature.setup(cfg)
signature.on_attach(cfg)
