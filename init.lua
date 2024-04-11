-- One tab is represented as 4 spaces in editor
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0  -- increase/decrease indent by the value defined in tabstop
vim.opt.expandtab = true  -- Replace tab with spaces

vim.opt.fileencoding = "utf-8"

-- Improve visibility of hard tabs, non-breaking spaces and trailing spaces
vim.opt.list = true
vim.opt.listchars = "tab:→·,nbsp:␣,trail:·"

vim.opt.termguicolors = true  -- enables RGB colors
vim.cmd("highlight Normal ctermbg=black guibg=black")
-- Make line numbers less prominent than main content (if activated with :set nu)
vim.opt.number = true
vim.cmd("highlight LineNr ctermfg=DarkGrey ctermbg=black guibg=black guifg=DarkGrey")
vim.opt.foldcolumn = "auto"  -- just display if folds are available
vim.cmd("highlight FoldColumn ctermbg=black guibg=black")
vim.opt.signcolumn = "number"  -- integrate into number column
vim.cmd("highlight SignColumn ctermbg=black guibg=black")

-- Limit diagnostic errors to the sign column (less distraction while writing). Instead, show via <space>e
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
vim.g.mapleader = " "
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
                   python = { coverage_command = "poetry run coverage json -q -o -"} 
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

-- Config inserted from https://github.com/astral-sh/ruff-lsp?tab=readme-ov-file#example-neovim
-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- If a language server implements code formatting, automatically apply when writing the file.
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                vim.lsp.buf.format({ async = false })
                vim.lsp.buf.code_action({
                    context = { only = { "source.organizeImports" } },
                    apply = true,
                })
            end,
        })
    end

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- `ruff-lsp` configuration
-- Taken from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- 
require('lspconfig').ruff_lsp.setup {
    on_attach = on_attach,
    init_options = {
        settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
        }
    }
}
