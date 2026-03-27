return {
    {
        "wtfox/jellybeans.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)
            require("jellybeans").setup(opts)
            vim.cmd.colorscheme("jellybeans")
        end,
    },
}
