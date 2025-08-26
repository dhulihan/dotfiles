-- this file contains my personal abbreviations
local M = {}

M.setup = function()
	-- Only replace cmds, not search; only replace the first instance
	local function cmd_abbrev(abbrev, expansion)
		local cmd = "cabbr "
			.. abbrev
			.. ' <c-r>=(getcmdpos() == 1 && getcmdtype() == ":" ? "'
			.. expansion
			.. '" : "'
			.. abbrev
			.. '")<CR>'
		vim.cmd(cmd)
	end

	-- Redirect `:h` to `:FloatingHelp`
	cmd_abbrev("h", "FloatingHelp")
	cmd_abbrev("help", "FloatingHelp")
	cmd_abbrev("helpc", "FloatingHelpClose")
	cmd_abbrev("helpclose", "FloatingHelpClose")

	-- quitty helpers
	cmd_abbrev("Qa", "qa")
	cmd_abbrev("Wq", "wq")
	--cmd_abbrev("Wa", "wa") -- This conflicts with things like WarningMessage and Wall
end

return M
