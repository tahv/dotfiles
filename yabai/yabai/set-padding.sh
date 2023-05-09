# Rember to allow execution of this file:
# chmod +x ~/.config/yabai/set-padding.sh

# https://github.com/koekeishiya/yabai/issues/975#issuecomment-907691988

num_windows=$(yabai -m query --windows --display 1 | jq '[.[] | select(."is-visible"==true and ."is-floating"==false)] | length')
# default_padding=10

# On a widescreen, add padding to the sides if there is only one window
if [[ $num_windows == 1 ]]
then
  yabai -m space --padding abs:10:10:600:600
  yabai -m space --gap abs:10
  # yabai -m config top_padding    $default_padding
  # yabai -m config bottom_padding $default_padding
  # yabai -m config left_padding   600
  # yabai -m config right_padding  600
  # yabai -m config window_gap     $default_padding
else
  yabai -m space --padding abs:10:10:10:10
  yabai -m space --gap abs:10
  # yabai -m config top_padding    $default_padding
  # yabai -m config bottom_padding $default_padding
  # yabai -m config left_padding   $default_padding
  # yabai -m config right_padding  $default_padding
  # yabai -m config window_gap     $default_padding
fi
