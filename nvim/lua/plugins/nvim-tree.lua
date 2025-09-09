return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
        init = function()
            vim.keymap.set("n", ",", ":NvimTreeToggle<CR>", { silent = true })
        end,

        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            local HEIGHT_RATIO = 0.8
            local WIDTH_RATIO = 0.5

            require("nvim-tree").setup({

                on_attach = function(bufnr)
                    local api = require "nvim-tree.api"

                    local function opts(desc)
                        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                    end

                    -- default mappings
                    api.config.mappings.default_on_attach(bufnr)

                    -- custom mappings
                    vim.keymap.set('n', 'l',     api.node.open.no_window_picker,   opts('Open: No Window Picker'))

                end,
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    -- width = 40,
                    -- side = "right",
                    float = {
                        enable = true,
                        quit_on_focus_loss = true,
                        open_win_config = function()
                            local screen_w = vim.opt.columns:get()
                            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                            local window_w = screen_w * WIDTH_RATIO
                            local window_h = screen_h * HEIGHT_RATIO
                            local window_w_int = math.floor(window_w)
                            local window_h_int = math.floor(window_h)
                            local center_x = (screen_w - window_w) / 2
                            local center_y = ((vim.opt.lines:get() - window_h) / 2) -
                            vim.opt.cmdheight:get()
                            return {
                                border = "rounded",
                                relative = "editor",
                                row = center_y,
                                col = center_x,
                                width = window_w_int,
                                height = window_h_int
                            }
                        end
                    },
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            })
        end,
    },
}

