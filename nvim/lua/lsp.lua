-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = "rounded" }) end, bufopts)
vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help({ border = "rounded", focusable = false }) end, bufopts)
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', '<space>c', vim.lsp.buf.code_action, bufopts)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

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

vim.lsp.config('pyright', {
  cmd = { "pyright-langserver", "--stdio" },
  root_markers = { "pyproject.toml", "uv.lock", ".git" },
  filetypes = { 'python' },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      }
    }
  }
})
if vim.fn.executable('pyright') == 1 then
    -- vim.lsp.enable('pyright')
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
