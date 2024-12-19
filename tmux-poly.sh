#!/bin/zsh
# Define colors for highlighting
normal_color="%{F-}"   # White (default color for inactive windows)
highlight_color="%{F#e2a0eb}" # Red (color for current window)

get_window_title() {
    # Get the window ID of the currently focused window
    window_id=$(xdotool getwindowfocus)

    # Get the title of the window using xprop
    xprop -id "$window_id" WM_NAME | sed -n 's/^.*= "\(.*\)"$/\1/p'
}

while true; do
    # Fetch the current window title
    window_title=$(get_window_title)


    # Check if the window title contains "tmux"
    if [[ "$window_title" == "tmux" ]] || [[ "$window_title" == "tmux attach" ]] || [[ "$window_title" == "tmux a" ]]; then
        # If the window title contains "tmux", display the current tmux window name
        current_session=$(tmux display-message -p '#S')

        current_window=$(tmux display-message -p '#I')
        window_string=""

        for window in $(tmux list-windows -t "$current_session" -F "#{window_index}:#{window_name}"); do
            window_index=$(echo "$window" | cut -d: -f1)
            window_name=$(echo "$window" | cut -d: -f2)

            # Highlight the current window
            if [[ "$window_index" == "$current_window" ]]; then
                window_string+="${highlight_color}${window_name}${normal_color} "
            else
                window_string+="${normal_color}${window_index}:${window_name} "
            fi

        done

        output="${normal_color}session${highlight_color} $current_session    $window_string"
        # echo "$(tmux display-message -p '#W')"
        echo $output
    else
        echo ''
    fi

    # Wait for 1 second before the next iteration
    sleep 1
done
