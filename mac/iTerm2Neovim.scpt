-- Open files in Neovim in a new iTerm window
-- You can use this script in Automator to create an .app.
on run {input, parameters}
	set nvimCommand to "nvim -p "
	set filepaths to ""

	if input is not {} then
		repeat with currentFile in input
			set filepaths to filepaths & quoted form of POSIX path of currentFile & " "
		end repeat
	end if

	if application "iTerm" is running then
		tell application "iTerm"
			create window with default profile
			tell current session of current window
				write text nvimCommand & filepaths
			end tell
		end tell
	else
		tell application "iTerm"
			activate
			tell current session of current window
				write text nvimCommand & filepaths
			end tell
		end tell
	end if
end run
