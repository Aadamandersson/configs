return {
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        config = function()
            local dap = require("dap")
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
            vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
            vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
            vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dB", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Set Conditional Breakpoint" })

            dap.adapters.go = function(callback, _)
                local port = 38697
                local handle
                handle = vim.loop.spawn("dlv", {
                    args = { "dap", "-l", "127.0.0.1:" .. port },
                    detached = true
                }, function(code)
                    handle:close()
                    print("Delve exited with code", code)
                end)

                vim.defer_fn(function()
                    callback({ type = "server", host = "127.0.0.1", port = port })
                end, 100)
            end

            dap.configurations.go = {
                {
                    type = "go",
                    name = "Debug File",
                    request = "launch",
                    program = "${file}",
                },
                {
                    type = "go",
                    name = "Debug Package",
                    request = "launch",
                    program = "${fileDirname}",
                },
            }
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end

            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    }
}
