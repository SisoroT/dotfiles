#!/bin/bash
# Get focused workspace column info via niri IPC
OUTPUT=$(niri msg --json focused-window 2>/dev/null)
if [ -z "$OUTPUT" ] || [ "$OUTPUT" = "null" ]; then
    echo ""
    exit 0
fi

# Get all windows on the current workspace
WS=$(niri msg --json workspaces | jq -r '.[] | select(.is_focused) | .id')
WINDOWS=$(niri msg --json windows | jq "[.[] | select(.workspace_id == $WS)]")
TOTAL=$(echo "$WINDOWS" | jq 'length')
FOCUSED_IDX=$(echo "$WINDOWS" | jq '[.[].is_focused] | index(true)')
CUR=$((FOCUSED_IDX + 1))

echo "$CUR/$TOTAL"
