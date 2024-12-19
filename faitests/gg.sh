
# Capture the output of `tmux choose-tree` without opening the interactive menu
output=$(tmux choose-tree -N -s)

# Check if `choose-tree` provided any output
if [[ -z "$output" ]]; then
  echo "No sessions, windows, or panes to display."
  exit 0
fi

# Parse the output and list all sessions, windows, and panes
while IFS= read -r line; do
  if [[ "$line" =~ ^Session.* ]]; then
    echo "Session: $(echo "$line" | awk -F':' '{print $2}')"
  elif [[ "$line" =~ ^Window.* ]]; then
    echo "  Window: $(echo "$line" | awk -F':' '{print $2}')"
  elif [[ "$line" =~ ^Pane.* ]]; then
    echo "    Pane: $(echo "$line" | awk -F':' '{print $2}')"
  fi
done <<< "$output"
