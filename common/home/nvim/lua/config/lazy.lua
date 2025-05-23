local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
            {out, "WarningMsg"},
            {"\nPress any key to exit..."},
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import plugins here
        {"morhetz/gruvbox"},

        -- Auto completion
        {"hrsh7th/nvim-cmp"},
        {"hrsh7th/cmp-path"},
        {"neovim/nvim-lspconfig"},
        {"hrsh7th/cmp-nvim-lsp"},

        -- Mason for automatic LSP install
        --{"williamboman/mason.nvim"},
        --{"williamboman/mason-lspconfig"},

        {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
        {"nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { 
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-live-grep-args.nvim" , version = "^1.0.0", },
        }},

        -- Markdown preview
        {
            "toppair/peek.nvim",
            event = { "VeryLazy" },
            build = "deno task --quiet build:fast",
            config = function()
                require("peek").setup({
                    app = {"brave", "--incognito"},
                })
                vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
                vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
            end,
        },
    },
    install = {colorscheme = {"gruvbox"} },
    checker = { enabled = true, notify = false},
})
