local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

local function get_indent(_, parent)
	local indent = parent.snippet.env.TM_CURRENT_LINE:match("^%s+") or ""
	return indent
end

function get_reg(char)
	--return vim.api.nvim_exec([[echo getreg(']] .. char .. [[')]], true):gsub("[\n\r]", "^J")
	--return vim.api.nvim_exec([[echo getreg(']] .. char .. [[')]], true)
	return vim.fn.getreg(char)
end

return {
	s("newline", {
		t({ "First line", "", "Third line" }),
		t({ "", "" }),
		t({ "xx" }),
	}),
	s("isn", {
		isn(1, {
			t({ "This is indented as deep as the trigger", "and this is at the beginning of the next line" }),
		}, "$PARENT_INDENT"),
	}),

	s({
		trig = "`",
		name = "fenced code block",
	}, {
		isn(0, {
			t({ "", "" }),
			t({ "\t```" }),
			i(1, "language"),
			t({ "", "\t" }),
			i(2, "code"),
			t({ "", "\t```" }),
		}, "$PARENT_INDENT"),
	}),

	-- create fenced code block from clipboard
	-- WARNING: this breaks when clipboard contains lua code. Something is getting evaluated.
	-- https://github.com/L3MON4D3/LuaSnip/discussions/1272
	s("`p", {
		isn(0, {
			t({ "", "" }),
			t({ "\t```" }),
			i(1, "language"),
			t({ "", "\t" }),
			f(function()
				--local clipboard = vim.fn.getreg("*")
				return get_reg("*")
			end, {}),
			t({ "", "\t```" }),
		}, "$PARENT_INDENT"),
	}),

	s({
		trig = "*ld",
		name = "Likes/Dislikes",
	}, {
		isn(0, {
			t({ "* Likes", "" }),
			t({ "\t* " }),
			i(1, ""),
			t({ "", "" }),
			t({ "* Dislikes", "" }),
			t({ "\t* " }),
			i(2, ""),
		}, "$PARENT_INDENT"),
	}),

	s({
		trig = "*ad",
		name = "Advantages/Disadvantages",
	}, {
		isn(0, {
			t({ "* Advantages", "" }),
			t({ "\t* " }),
			i(1, ""),
			t({ "", "" }),
			t({ "* Disadvantages", "" }),
			t({ "\t* " }),
			i(2, ""),
		}, "$PARENT_INDENT"),
	}),
}, {
	--s("autotrig", t("autotriggered, if enabled")),
}

--ls.add_snippets("markdown", {
--s("foo", {
--ls.t({ 0 }, "foo"),
--}),
--}, {
--key = "markdown",
--})

--aooo
