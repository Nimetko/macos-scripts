#!/usr/bin/env bash

# -- Path to your MPD config if needed --
# MPD_CONF="$HOME/.config/mpd/mpd.conf"
# MPD_CONF="~/.config/mpd/mpd.conf"
# not working above, because ~ is not evaluated as a string

MPD_CONF=~/.config/mpd/mpd.conf

# Function to ensure MPD is running
function ensure_mpd {
  if ! pgrep -x mpd > /dev/null; then
    echo "🔄 mpd not running — starting..."
    # If using custom config:
    mpd "$MPD_CONF"
    # Or default:
    # mpd
  else
    echo "✅ mpd is already running"
  fi

  echo "Updating Database"
  mpc update
}

function launch_rmpc {
  echo "🖥️ Launching rmpc..."
  rmpc
}

function play_with_mpv {
  # optional: play stream or file via mpv
  echo "🎵 mpv control optional; rmpc handles MPD control"
}

# Main
ensure_mpd
launch_rmpc
# Optionally: play_with_mpv

