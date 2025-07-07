-- Unit test function
function runTests()
	local testCases = {
		{ input = "foo: bar", expected = "* `foo` - bar" },
		{ input = "foo - bar", expected = "* `foo` - bar" },
		--{ input = "title: My Book", expected = '* "title" - My Book' },
		--{ input = "year: 2025", expected = '* "year" - 2025' },
		--{ input = "author:John Doe", expected = '* "author" - John Doe' },
		--{
		--input = "description: This is a long description with multiple words",
		--expected = '* "description" - This is a long description with multiple words',
		--},
		--{ input = "empty:", expected = '* "empty" - ' },
		--{ input = "no_change", expected = "no_change" },
	}

	local passedTests = 0
	local totalTests = #testCases

	for i, testCase in ipairs(testCases) do
		local result = convert_bulleted_inline_snippet(testCase.input)
		local testPassed = result == testCase.expected

		if testPassed then
			passedTests = passedTests + 1
			print(string.format("Test %d passed", i))
		else
			print(string.format("Test %d failed", i))
			print("  Input:    " .. testCase.input)
			print("  Expected: " .. testCase.expected)
			print("  Got:      " .. result)
		end
	end

	print(string.format("\nPassed %d out of %d tests", passedTests, totalTests))
	assert(passedTests == totalTests, "Not all tests passed")
end

-- Run the tests
runTests()
