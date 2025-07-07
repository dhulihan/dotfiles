M = {}
-- convert(copy from the original script)
M.convert_bulleted_inline_snippet = function(input)
	local converted = input:gsub("(%w+):%s*(.+)", "`%1` - %2")
	--TODO: support more cases
	--converted = converted:gsub("(%w+)%s-%s*(.+)", "`%1` - %2")
	return converted
end

return M
