local function arrangeIterm(externalFrame, externalScreen)
	local iterm = hs.application.get("iTerm2")
	if not iterm then
		return
	end

	local mainWin = nil
	local notesWin = nil

	for _, win in ipairs(iterm:allWindows()) do
		local title = win:title() or ""
		if title == "Default" then
			notesWin = win
		elseif not mainWin then
			mainWin = win
		end
	end

	if mainWin then
		mainWin:moveToScreen(externalScreen)
		mainWin:setFrame(externalFrame)
	end

	if notesWin then
		notesWin:moveToScreen(externalScreen)
		notesWin:setFrame({
			x = externalFrame.x + externalFrame.w / 2,
			y = externalFrame.y,
			w = externalFrame.w / 2,
			h = externalFrame.h,
		})
	end
end

local function arrangeBrave(laptopFrame, laptopScreen, externalFrame, externalScreen)
	local brave = hs.application.get("Brave Browser")
	if not brave then
		hs.alert.show("Brave Browser is not running")
		return
	end

	local calendarWin = nil
	local mailWin = nil

	for _, win in ipairs(brave:allWindows()) do
		local title = win:title() or ""
		if title:find("Calendar") then
			calendarWin = win
		elseif title:find("Mail") or title:find("Chat") then
			mailWin = win
		end
	end

	if calendarWin then
		calendarWin:moveToScreen(laptopScreen)
		calendarWin:setFrame(laptopFrame)
	else
		hs.alert.show("Calendar window not found")
	end

	if mailWin then
		mailWin:moveToScreen(externalScreen)
		mailWin:setFrame({
			x = externalFrame.x,
			y = externalFrame.y,
			w = externalFrame.w / 2,
			h = externalFrame.h,
		})
	else
		hs.alert.show("Mail/Chat window not found")
	end
end

local function arrangeSlack(externalFrame, externalScreen)
	local slack = hs.application.get("Slack")
	if not slack then
		return
	end

	local windows = slack:allWindows()
	if #windows > 0 then
		local slackWin = windows[1]
		slackWin:moveToScreen(externalScreen)
		slackWin:setFrame({
			x = externalFrame.x + externalFrame.w / 2,
			y = externalFrame.y,
			w = externalFrame.w / 2,
			h = externalFrame.h,
		})
	end
end

local function arrangeClaude(externalFrame, externalScreen)
	local claudeWin = nil
	for _, win in ipairs(hs.window.allWindows()) do
		local title = win:title() or ""
		if title:find("Claude") then
			claudeWin = win
			break
		end
	end

	if not claudeWin then
		hs.alert.show("Claude window not found")
		return
	end

	local w = externalFrame.w * 0.5
	local h = externalFrame.h * 0.7

	claudeWin:moveToScreen(externalScreen)
	claudeWin:setFrame({
		x = externalFrame.x + (externalFrame.w - w) / 2,
		y = externalFrame.y + (externalFrame.h - h) / 2,
		w = w,
		h = h,
	})
end

hs.hotkey.bind({ "cmd", "ctrl", "shift" }, "r", function()
	hs.reload()
	hs.alert.show("hammerspoon config reloaded")
end)

hs.hotkey.bind({ "cmd", "ctrl", "shift" }, "n", function()
	hs.alert.show("test alert")
end)

hs.hotkey.bind({ "cmd", "ctrl", "shift" }, "w", function()
	local externalScreen = nil
	local laptopScreen = hs.screen.primaryScreen()
	for _, screen in ipairs(hs.screen.allScreens()) do
		if screen ~= laptopScreen then
			externalScreen = screen
			break
		end
	end

	if not externalScreen then
		hs.alert.show("No external monitor found")
		return
	end

	local laptopFrame = laptopScreen:frame()
	local externalFrame = externalScreen:frame()

	arrangeIterm(externalFrame, externalScreen)
	arrangeBrave(laptopFrame, laptopScreen, externalFrame, externalScreen)
	arrangeSlack(externalFrame, externalScreen)
	arrangeClaude(externalFrame, externalScreen)

	hs.alert.show("Windows arranged")
end)

hs.hotkey.bind({ "cmd", "ctrl", "shift" }, "b", function()
	local externalScreen = nil
	local laptopScreen = hs.screen.primaryScreen()

	for _, screen in ipairs(hs.screen.allScreens()) do
		if screen ~= laptopScreen then
			externalScreen = screen
			break
		end
	end

	if not externalScreen then
		hs.alert.show("No external monitor found")
		return
	end

	local brave = hs.application.get("Brave Browser")
	if not brave then
		hs.alert.show("Brave Browser is not running")
		return
	end

	local calendarWin = nil
	local mailWin = nil

	for _, win in ipairs(brave:allWindows()) do
		local title = win:title() or ""
		if title:find("Calendar") then
			calendarWin = win
		elseif title:find("Mail") or title:find("Chat") then
			mailWin = win
		end
	end

	local slack = hs.application.get("Slack")
	local slackWin = nil
	if slack then
		local windows = slack:allWindows()
		if #windows > 0 then
			slackWin = windows[1]
		end
	end

	local laptopFrame = laptopScreen:frame()
	local externalFrame = externalScreen:frame()

	-- Calendar window: 100% of laptop screen
	if calendarWin then
		calendarWin:moveToScreen(laptopScreen)
		calendarWin:setFrame(laptopFrame)
	else
		hs.alert.show("Calendar window not found")
	end

	-- Mail window: 50% width, left side of external monitor
	if mailWin then
		mailWin:moveToScreen(externalScreen)
		mailWin:setFrame({
			x = externalFrame.x,
			y = externalFrame.y,
			w = externalFrame.w / 2,
			h = externalFrame.h,
		})
	else
		hs.alert.show("Mail/Chat window not found")
	end

	-- Slack window: 50% width, right side of external monitor
	if slackWin then
		slackWin:moveToScreen(externalScreen)
		slackWin:setFrame({
			x = externalFrame.x + externalFrame.w / 2,
			y = externalFrame.y,
			w = externalFrame.w / 2,
			h = externalFrame.h,
		})
	else
		hs.alert.show("Slack window not found")
	end

	if calendarWin or mailWin or slackWin then
		hs.alert.show("Windows arranged")
	end
end)
