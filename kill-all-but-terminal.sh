#!/bin/bash

# Apps we want to KEEP alive (exact process names from Activity Monitor)
WHITELIST=("Terminal" "BetterTouchTool")

# Turn whitelist array into a grep pattern like: Terminal|BetterTouchTool
WHITELIST_PATTERN=$(printf "%s\n" "${WHITELIST[@]}" | paste -sd'|' -)

# Get list of running GUI apps (not background daemons/agents)
# `osascript` asks System Events for names of visible processes with a window
RUNNING_APPS=$(osascript <<'END'
tell application "System Events"
	set appList to name of (every process whose background only is false)
end tell
return appList
END
)

# Turn AppleScript return (comma-separated) into line-separated
APP_LIST=$(echo "$RUNNING_APPS" | tr ',' '\n' | sed 's/^ *//;s/ *$//')

echo "Running apps:"
echo "$APP_LIST"
echo

# Filter out whitelisted apps
APPS_TO_KILL=$(echo "$APP_LIST" | grep -Ev "^(${WHITELIST_PATTERN})$")

echo "Will quit these:"
echo "$APPS_TO_KILL"
echo

# Kill them
while IFS= read -r app; do
    if [ -n "$app" ]; then
        echo "Killing: $app"
        # First try to quit nicely
        osascript -e "tell application \"$app\" to quit" 2>/dev/null
        # Give it a moment
        sleep 0.3
        # If it's still running, force kill all its PIDs
        pkill -9 -x "$app" 2>/dev/null
    fi
done <<< "$APPS_TO_KILL"

echo "Done."
