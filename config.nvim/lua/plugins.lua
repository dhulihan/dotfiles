-- nvim-dap --------------------------------------------------------------------
--
local ok, dap = pcall(require, "dap")
if not ok then
	return
end

require("dap").set_log_level("DEBUG")
require("dapui").setup()
require("dap-go").setup()
require("nvim-dap-virtual-text").setup()
--require("dapui").open()
--require("dapui").close()
--require("dapui").toggle()
-- events
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- nvim-dap END ----------------------------------------------------------------
-- telescope
require("telescope").setup()
require("telescope").load_extension("dap")
