local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
    return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
    return
end

dapui.setup()

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

local setup_codelldb = function()
    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-1.9.1/adapter/codelldb",
            args = { "--port", "${port}" },
        },
    }

    dap.configurations.rust = {
        {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = function()
                local args = vim.fn.input("Program arguments: ")
                return vim.fn.split(args, " ", true)
            end,

            -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
            --
            --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            --
            -- Otherwise you might get the following error:
            --
            --    Error on launch: Failed to attach to the target process
            --
            -- But you should be aware of the implications:
            -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
            -- runInTerminal = false,
        },
    }
end

local dap_vscode_status_ok, dap_vscode = pcall(require, "dap.ext.vscode")
if not dap_vscode_status_ok then
    setup_codelldb()
    return
end

-- Map adapters to configurations for `load_launchjs`
local adapter_map = {
    rt_lldb = { "rust" },
}

-- Parse `.vscode/launch.js` if one is present in the workspace
dap_vscode.load_launchjs(nil, adapter_map)

local launch_path = (vim.fn.getcwd() .. "/.vscode/launch.json")
if not vim.loop.fs_stat(launch_path) then
    setup_codelldb()
end
