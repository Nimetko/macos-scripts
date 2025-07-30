#!/usr/bin/env bash

# stop_music.sh

echo "🔇 Stopping MPD..."
if systemctl --user is-active --quiet mpd; then
  systemctl --user stop mpd && echo "✅ systemd user mpd stopped"
else
  if pidof mpd > /dev/null; then
    echo "🛑 Using mpd --kill"
    mpd --kill
  else
    echo "ℹ️  mpd not running"
  fi
fi

echo "🛑 Killing rmpc..."
killall rmpc 2>/dev/null && echo "✅ rmpc terminated" || echo "ℹ️  rmpc not running"

echo "🛑 Killing mpv..."
killall mpv 2>/dev/null && echo "✅ mpv terminated" || echo "ℹ️  mpv not running"

echo "🎵 All music services stopped."
exit 0
