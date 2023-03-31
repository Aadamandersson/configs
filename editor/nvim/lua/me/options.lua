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
	ignorecase = true,
	smartcase = true,
	mouse = "a",
	encoding = "utf-8",
	fileencoding = "utf-8",
	printencoding = "utf-8",
}

for k, v in pairs(opts) do
	vim.opt[k] = v
end
