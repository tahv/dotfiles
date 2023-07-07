# Allow execution of this file:
# chmod +x ~/.config/yabai/set-padding.sh

# https://github.com/koekeishiya/yabai/issues/975#issuecomment-907691988

visible_spaces=$(yabai -m query --spaces | jq -c '.[] | select(."is-visible"==true)')

for row in $visible_spaces; do
  space=$(echo $row | jq '.index')
  display=$(echo $row | jq '.display')
  display_width=$(yabai -m query --displays --display $display | jq '.frame.w')
  num_windows=$(yabai -m query --windows --display $display | jq '[.[] | select(."is-visible"==true and ."is-floating"==false)] | length')

  # On a widescreen, add padding to the sides if there is only one window
  if [ $display_width -ge 3440 ] && [ $num_windows -eq 1 ]
  then
    # widescreen with only one managed window
    yabai -m space $space --padding abs:10:10:600:600
    # yabai -m space $space --gap abs:10
    # echo $space $display $display_width $space widescreen one win
  else
    # native screen or widescreen with multiple managed windowss
    yabai -m space $space --padding abs:10:10:10:10
    # yabai -m space $space --gap abs:10
    # echo $space $display $display_width $space base case
  fi
done
