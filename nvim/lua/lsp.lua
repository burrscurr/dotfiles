-- Enable a language server if its command is actually available on the local machine.
-- This allows sharing the config between machines without assuming all configured
-- language servers are locally available.
local enable_lsp_if_available = function(lsp_config_name, command_name)
    if vim.fn.executable(command_name) then
        vim.lsp.enable(lsp_config_name)
    end
end

-- Mappings.
local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = "rounded" }) end, bufopts)
vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help({ border = "rounded", focusable = false }) end, bufopts)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)

-- Use CTRL-space to trigger LSP completion.
vim.keymap.set('i', '<c-space>', function() vim.lsp.completion.get() end)
-- When a completion window is open, but no entry was selected, let Tab select (Ctrl+N)
-- and accept (Ctrl+Y) the first entry (instead of literally inserting a tab character).
vim.cmd("inoremap <expr> <tab> pumvisible() && get(complete_info(), 'selected', -1) ? '<c-n><c-y>' : '<tab>'")

vim.lsp.inlay_hint.enable()

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
enable_lsp_if_available('ruff', 'ruff')

vim.lsp.config('ty', {
    cmd = { 'ty', 'server' },
    filetypes = { 'python' },
    root_markers = { "pyproject.toml", "uv.lock", ".git" },
    settings = {
        ty = {
            diagnosticMode = 'workspace',
            experimental = {
                rename = true,
            },
            inlayHints = {
                variableTypes = false,
                callArgumentNames = false,
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
enable_lsp_if_available('ty', 'ty')

vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { "Cargo.lock", ".git" },
})
enable_lsp_if_available('rust_analyzer', 'rust-analyzer')
vim.g.rustfmt_autosave = 1

vim.lsp.config("marksman", {
  cmd = { "marksman", "server" },
  filetypes = { "markdown" },
  root_markers = { ".marksman.toml", ".git" }
})
enable_lsp_if_available('marksman', 'marksman')

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
enable_lsp_if_available('cssls', 'vscode-css-language-server')
