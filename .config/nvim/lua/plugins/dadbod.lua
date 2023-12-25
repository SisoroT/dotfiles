-- allows for interatction with databases
return {
    "tpope/vim-dadbod",
    -- provides a ui for vim-dadbod
    dependencies = {
        "kristijanhusak/vim-dadbod-ui",
        keys = {
            -- toggle DBUI
            { "<leader>du", ":DBUIToggle<CR>" },
            -- run entire file
            { "<leader>db", ":%DB<CR>" },
            -- run selection
            { "<leader>db", ":DB<CR>",        mode = "v" },
        },

        config = function()
            local opts = { noremap = true, silent = true }

            -- run selection
            -- vim.api.nvim_set_keymap("v", "<leader>db", ":DB<CR>", opts)

            -- set database connection as global variable
            vim.g.db = "mysql://sisoro:Kurisu@localhost/valorant"
            require("plugins.dadbod")
        end,
    },
}
