return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mxsdev/nvim-dap-vscode-js",
    {
      "microsoft/vscode-js-debug",
      version = "1.x",
      build = "npm i && npm run compile vsDebugServerBundle && mv dist out"
    }
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local jsdebug = require('dap-vscode-js')
    jsdebug.setup({
      adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
      debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug",
    })

    local js_based_languages = { "typescript", "typescriptreact", "javascript" }
    for _, language in ipairs(js_based_languages) do
      require("dap").configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          processId = require 'dap.utils'.pick_process,
          name = "Attach debugger to existing `node --inspect` process",
          port = function()
            return vim.fn.input("Select port: ", 9229)
          end,
          cwd = vim.fn.getcwd(),
          -- for compiled languages like TypeScript or Svelte.js
          -- path to src in vite based projects (and most other projects as well)
          -- we don't want to debug code inside node_modules, so skip it!
          skipFiles = { "<node_internals>/**" }
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Start Chrome with \"localhost\"",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
        }
      }
    end
    dapui.setup({})
    vim.keymap.set('n', '<Leader>dt', dap.toggle_breakpoint, { desc = "Debugger: toggle breakpoin" })
    vim.keymap.set('n', '<Leader>dc', dap.continue, { desc = 'Debugger: continue execution' })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  end
}
