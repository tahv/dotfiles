# Allow execution of this file:
# chmod +x ~/.config/yabai/set-split.sh

num_windows=$(yabai -m query --windows --display 1 | jq '[.[] | select(."is-visible"==true and ."is-floating"==false)] | length')

# On a widescreen, force the third window stack horizontally.
if [[ $num_windows == 2 ]]
then
  yabai -m config split_type horizontal
else
  yabai -m config split_type auto
fi
