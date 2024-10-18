on run {input, parameters}
	set viewCMD to "jless "
	set editCMD to "nvim "
	set filepaths to ""

	if input is not {} then
		repeat with currentFile in input
			set filepaths to filepaths & quoted form of POSIX path of currentFile & " "
		end repeat
	end if

	tell application "Terminal"
		activate
		do script viewCMD & filepaths & " ; exit "
	end tell
end run
