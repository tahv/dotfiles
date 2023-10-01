# Allow execution of this file:
# chmod +x ~/.config/yabai/set-padding.sh

# https://github.com/koekeishiya/yabai/issues/975#issuecomment-907691988

visible_spaces=$(yabai -m query --spaces | jq -c '.[] | select(."is-visible"==true)')

for row in $visible_spaces; do
  space=$(echo $row | jq '.index')
  display=$(echo $row | jq '.display')
  display_width=$(yabai -m query --displays --display $display | jq '.frame.w')
  num_windows=$(yabai -m query --windows --display $display | jq '[.[] | select(."is-visible"==true and ."is-floating"==false)] | length')
  # echo space: $space, display: $display, width: $display_width, num_wins: $num_windows
  
  # On a widescreen, add padding to the sides if there is only one window.
  # Using bc (basic calculator). Bash does not support floating point arithmetic.
  # https://stackoverflow.com/a/31087503
  if (( $(echo "$display_width >= 3440" | bc -l) )) && [ $num_windows -eq 1 ]
  then
    # widescreen with only one managed window
    yabai -m space $space --padding abs:10:10:600:600
    # yabai -m space $space --gap abs:10
  else
    # native screen or widescreen with multiple managed windowss
    yabai -m space $space --padding abs:10:10:10:10
    # yabai -m space $space --gap abs:10
  fi
done
