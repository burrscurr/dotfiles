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

vim.opt.termguicolors = true  -- enables RGB colors
vim.cmd("colorscheme torte")
vim.cmd("highlight Normal ctermbg=black guibg=black")
-- Make line numbers less prominent than main content (if activated with :set nu)
vim.opt.number = true
vim.cmd("highlight LineNr ctermfg=DarkGrey ctermbg=black guibg=black guifg=DarkGrey")
vim.opt.foldcolumn = "auto"  -- just display if folds are available
vim.cmd("highlight FoldColumn ctermbg=black guibg=black")
vim.opt.signcolumn = "number"  -- integrate into number column
vim.cmd("highlight SignColumn ctermbg=black guibg=black")
vim.opt.scrolloff = 8  -- always show at least this number of lines above/below the cursor

vim.g.mapleader = " "

-- Limit diagnostic errors to the sign column (less distraction while writing). Instead, show via <leader>e
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = {
        border = "single",
        format = function(diagnostic)
            return string.format(
                "%s (%s) [%s]",
                diagnostic.message,
                diagnostic.source,
                diagnostic.code or diagnostic.user_data.lsp.code
            )
        end,
    },
})
vim.cmd("highlight DiagnosticUnderlineError cterm=undercurl gui=undercurl guisp=DarkGrey")
vim.api.nvim_set_hl(0, 'NormalFloat', {bg='black'})  -- default background is colorful, making red/yellow text hard to read

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

-- Setup lazy.nvim (plugin manager-- Setup lazy.nvim (plugin manager))
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "https://github.com/nvim-lua/plenary.nvim", name = "plenary" },
    { "https://github.com/neovim/nvim-lspconfig"},
    "https://github.com/itchyny/lightline.vim",
    {
        "https://github.com/andythigpen/nvim-coverage",
        dependencies = { "plenary" },
        cmd = { "CoverageShow" },
        lazy = false,
        config = function()
            require("coverage").setup({
                lang = {
                   python = { coverage_command = "python -m coverage json -q -o -"}
                }
            })
        end,
    },
    { "https://github.com/junegunn/fzf", dir = "~/.fzf", build = "./install --no-completion --no-update-rc --key-bindings --bin" },

    -- Syntax highlighting for various languages
    { "https://github.com/udalov/kotlin-vim" },
    { "https://github.com/vim-python/python-syntax" },
    { "https://github.com/moon-musick/vim-logrotate" },
    { "https://github.com/uiiaoo/java-syntax.vim" },
    { "https://github.com/projectfluent/fluent.vim" },
    { "https://github.com/lifepillar/pgsql.vim.git" },
    { "https://github.com/burrscurr/vim-pgpass.git" },
    { "https://github.com/lervag/vimtex" },
    { "https://github.com/niklasl/vim-rdf" },
    { "https://github.com/rust-lang/rust.vim" },
})

-- Configure fzf integration (probably not required anymore since lazy.nvim manages packages)
-- vim.opt.rtp:append { '~/.fzf' }
vim.keymap.set('n', '<C-p>', ':FZF<cr>', { noremap=true, silent=true })

require("lsp")
