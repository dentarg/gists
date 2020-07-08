activate application "Canon IJ Scan Utility"

tell application "System Events"
	tell window 1 of process "Canon IJ Scan Utility"
		click button "Document"
	end tell
end tell

do shell script "open /Users/dentarg/Pictures/canoscan-9000f-mkii"
