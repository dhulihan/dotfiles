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
		trig = "`o",
		name = "fenced code block (old)",
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

	s({
		trig = "`",
		name = "fenced code block from clipboard (indented)",
	}, {
		isn(0, {
			t({ "", "" }),
			t({ "\t```" }),
			i(1, "language"),
			t({ "", "\t" }),
			f(function()
				local clip = vim.fn.getreg("+")
				-- Strip trailing newline so the closing fence sits on its own line cleanly
				clip = clip:gsub("\n$", "")
				return vim.split(clip, "\n", { plain = true })
			end),
			t({ "", "\t```" }),
		}, "$PARENT_INDENT"),
	}),

	-- luasnip isn't auto indenting, so we're going to create a separate snipped for root level (start of line) code blocks
	s({
		trig = "`p",
		name = "Paste clipboard into fenced code block",
		dscr = "GitHub-style fenced code block with clipboard contents",
		--snippetType = "autosnippet",
		--condition = function(line_to_cursor)
		--return line_to_cursor:match("^%s*$")
		--end,
	}, {
		t({ "", "" }),
		t("```"),
		i(1, "language"),
		t({ "", "" }),
		f(function()
			local clip = vim.fn.getreg("+")
			-- Strip trailing newline so the closing fence sits on its own line cleanly
			clip = clip:gsub("\n$", "")
			return vim.split(clip, "\n", { plain = true })
		end),
		t({ "", "```" }),
		i(0),
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

	s({
		trig = "* qx",
		name = "markdown_link",
		dscr = "daily log entry, multiple categories",
	}, {
		t("* "),
		f(function()
			return os.date("%Y-%m-%d")
		end, {}),
		t({ "", "" }), -- newline
		t({ "    * 10%", "" }),
		t("        * "),
		i(1),
		t({ "", "" }), -- newline
		t({ "    * 20%", "" }),
		t("        * "),
		i(2),
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
