-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = "rounded" }) end, bufopts)
vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help({ border = "rounded", focusable = false }) end, bufopts)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)

-- Use CTRL-space to trigger LSP completion.
vim.keymap.set('i', '<c-space>', function()
    vim.lsp.completion.get()
end)
-- When a completion window is open, but no entry was selected, let Tab select (Ctrl+N)
-- and accept (Ctrl+Y) the first entry (instead of literally inserting a tab character).
vim.cmd("inoremap <expr> <tab> pumvisible() && get(complete_info(), 'selected', -1) ? '<c-n><c-y>' : '<tab>'")

vim.lsp.config('ruff', {
    cmd = { 'ruff', 'server' },
    root_markers = { "pyproject.toml", "uv.lock", ".git" },
    filetypes = { 'python' },
    on_attach = function(client, bufnr)
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
                vim.lsp.buf.code_action({
                    context = { only = { "source.organizeImports" } },
                    apply = true,
                })
            end,
        })
    end
})
if vim.fn.executable('ruff') == 1 then
    vim.lsp.enable('ruff')
end

vim.lsp.config('ty', {
    cmd = { 'ty', 'server' },
    filetypes = { 'python' },
    root_markers = { "pyproject.toml", "uv.lock", ".git" },
    settings = {
        ty = {
            experimental = {
                rename = true,
            },
        },
    },
    on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(item)
                return {
                    abbr = item.label:gsub('%b()', ''),
                    kind = vim.lsp.protocol.CompletionItemKind[item.kind] or ""
                }
            end,
        })
    end,
})
if vim.fn.executable('ty') == 1 then
    vim.lsp.enable('ty')
end

vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { "Cargo.lock", ".git" },
})
if vim.fn.executable('rust-analyzer') == 1 then
    vim.lsp.enable('rust_analyzer')
end
vim.g.rustfmt_autosave = 1

vim.lsp.config("marksman", {
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
  root_markers = { ".marksman.toml", ".git" }
})
if vim.fn.executable("marksman") == 1 then
    vim.lsp.enable("marksman")
end

-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#cssls
vim.lsp.config("cssls", {
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "scss", "less" },
    init_options = {
        provideFormatter = true
    },
    root_markers = { "package.json", ".git" },
    settings = {
        css = {
            validate = true
        },
        less = {
            validate = true
        },
        scss = {
            validate = true
        }
    }
})

if vim.fn.executable("vscode-css-language-server") == 1 then
    vim.lsp.enable("cssls")
end
