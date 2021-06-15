-- nvim-lspconfig
if pcall(require, 'lspconfig') then
    require'lspconfig'.clangd.setup{}               -- pacman -S clang
    require'lspconfig'.gopls.setup{}                -- pacman -S gopls
    require'lspconfig'.rust_analyzer.setup{}        -- pacman -S rust-analyzer
    require'lspconfig'.bashls.setup{}               -- pacman -S bash-language-server
    require'lspconfig'.pyright.setup{}              -- paru -S pyright
    require'lspconfig'.tsserver.setup{}             -- paru -S typescript-language-server-bin
    require'lspconfig'.intelephense.setup{}         -- paru -S nodejs-intelephense
    require'lspconfig'.sumneko_lua.setup {          -- paru -S lua-language-server
        cmd = {'lua-language-server', '-E', '/usr/share/lua-language-server/main.lua'};
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                    -- Setup your lua path
                    path = vim.split(package.path, ';'),
                },
                diagnostics = {
                    -- vim/awesome globals
                    globals = {'vim', 'awesome', 'client', 'screen', 'root'},
                    disable = {'lowercase-global'},
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = {
                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                    },
                },
            },
        },
    }
end

-- vim: set ts=4 sw=4 tw=0 et :
