-- set uiScript to "click menu item \"Unmute Audio\" of menu 1 of menu bar item 1 of menu bar 2 of application process \"zoom.us\""
-- my doWithTimeout(uiScript)

set uiScript to "click menu item \"Mute Audio\" of menu 1 of menu bar item 1 of menu bar 2 of application process \"zoom.us\""
my doWithTimeout(uiScript)

on doWithTimeout(uiScript)
	try
		run script "tell application \"System Events\"
" & uiScript & "
end tell"
		exit repeat
	on error errorMessage
	end try
end doWithTimeout
