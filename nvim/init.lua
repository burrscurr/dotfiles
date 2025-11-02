-- One tab is represented as 4 spaces in editor
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0  -- increase/decrease indent by the value defined in tabstop
vim.opt.expandtab = true  -- Replace tab with spaces

vim.opt.fileencoding = "utf-8"
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Improve visibility of hard tabs, non-breaking spaces and trailing spaces
vim.opt.list = true
vim.opt.listchars = "tab:→·,nbsp:␣,trail:·"

vim.opt.mouse = a
vim.opt.termguicolors = true  -- enables RGB colors
vim.cmd("highlight Normal ctermbg=black guibg=black")
vim.opt.number = true
vim.opt.signcolumn = "number"  -- integrate into number column
vim.opt.scrolloff = 8  -- always show at least this number of lines above/below the cursor

vim.g.mapleader = " "

vim.cmd([[
    autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab
    autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd Filetype htmldjango setlocal ts=2 sts=2 sw=2 expandtab
    autocmd Filetype css setlocal ts=2 sw=2 sts=2 expandtab
    autocmd Filetype scss setlocal ts=2 sw=2 sts=2 expandtab
    autocmd Filetype svg setlocal ts=2 sts=2 sw=2 expandtab
    autocmd Filetype make setlocal noexpandtab
    autocmd Filetype yaml setlocal ts=2 sw=2 sts=2 expandtab
    autocmd Filetype bib setlocal ts=2 sw=2 sts=2 expandtab
    autocmd Filetype markdown setlocal ts=2 sts=2 sw=2 expandtab tw=80 nonumber
    let g:tex_flavor = 'latex'
    autocmd Filetype tex setlocal ts=2 sw=2 sts=2 expandtab tw=80 spell spelllang=de_de nonumber
    autocmd Filetype gitcommit setlocal nonumber
    autocmd Filetype gitrebase setlocal nonumber
    autocmd FileType help wincmd L
]])

vim.pack.add({
    "https://github.com/itchyny/lightline.vim",
    "https://github.com/nvim-treesitter/nvim-treesitter",

    -- Syntax highlighting for various languages
    "https://github.com/udalov/kotlin-vim",
    "https://github.com/vim-python/python-syntax",
    "https://github.com/moon-musick/vim-logrotate",
    "https://github.com/uiiaoo/java-syntax.vim",
    "https://github.com/projectfluent/fluent.vim",
    "https://github.com/lifepillar/pgsql.vim.git",
    "https://github.com/burrscurr/vim-pgpass.git",
    "https://github.com/lervag/vimtex",
    "https://github.com/niklasl/vim-rdf",
    "https://github.com/rust-lang/rust.vim",

    -- Colorschemes
    "https://github.com/scottmckendry/cyberdream.nvim",
    "https://github.com/tomasr/molokai",
})

vim.cmd("colorscheme cyberdream")

-- Always display completions in a popup window, even if there is just one option.
vim.cmd("set completeopt+=menuone,noselect,popup")

-- The default overlay has no border, making it difficult to read
vim.diagnostic.config({
    float = { border = "rounded" },
})
-- Make warnings a little less prominent to reduce distraction when typing
vim.cmd("highlight DiagnosticUnderlineWarn cterm=undercurl gui=undercurl guisp=DarkGrey")

-- Try to set up treesitter whenever a buffer is opened
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local ft = vim.bo.filetype
        pcall(vim.treesitter.start, 0, ft)
    end,
})
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- :CoverageShow etc.
vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/andythigpen/nvim-coverage",
})
require('coverage').setup()

-- File picker using fzf
vim.opt.rtp:append { '~/.fzf' }
vim.keymap.set('n', '<C-p>', ':FZF<cr>', { noremap=true, silent=true })

require("lsp")
