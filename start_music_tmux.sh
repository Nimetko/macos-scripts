#!/usr/bin/env bash

session_name="music"
window_name="music"
session_dir="$HOME/x/scripts"
script_path="$HOME/x/scripts/start_music.sh"

# Check if music is already playing (force connection to MPD)
is_playing=$(mpc --host=localhost status 2>/dev/null | grep -q '\[playing\]' && echo yes || echo no)

# Start tmux session if needed
if ! tmux has-session -t "$session_name" 2>/dev/null; then 
    tmux new-session -s "$session_name" -c "$session_dir" -d
fi

# Check if window exists
if ! tmux list-windows -t "$session_name" | grep -q "$window_name"; then
    if [[ "$is_playing" == "no" ]]; then
        echo "🎵 No music playing, running $script_path..."
        tmux new-window -t "$session_name" -n "$window_name" -c "$session_dir" "$script_path"
        sleep 0.3
        tmux rename-window -t "$session_name" "$window_name"
    else
        echo "🎧 Music is already playing, creating empty music window..."
        tmux new-window -t "$session_name" -n "$window_name" -c "$session_dir"
    fi
fi

# Always switch to the session/window
tmux switch-client -t "$session_name"
tmux select-window -t "$session_name:$window_name"

echo "🎧 Switched to session: $session_name, window: $window_name"
