#!/bin/sh

# monitors=$(xrandr | grep -sw 'connected' | cut -d " " -f 1)

# layout_laptop_only() {
#   bspc monitor -d I II III IV V VI VII VIII IX X
# }

# layout_external() {
#   bspc monitor eDP-1 -d I II III IV V
#   bspc monitor HDMI-1-0 -d VI VII VIII IX X
# }

# for m in $monitors
# do
#   if [[ "$m" == "HDMI-1-0" ]]; then
#     layout_external
#   else
#     layout_laptop_only
#   fi
# done

  I=1
  M=$(bspc query -M | wc -l)
  if [[ "$M" == 1 ]]; then
    bspc monitor -d I II III IV V VI VII VIII IX X
  elif [[ "$M" == 2 ]]; then
    bspc monitor $(bspc query -M | awk NR==1) -d I II III IV V
    bspc monitor $(bspc query -M | awk NR==2) -d VI VII VIII IX X
  else
    for monitor in $(bspc query -M); do
    bspc monitor $monitor \
        -n "$I" \
        -d $I/{a,b,c}
    let I++
  done
fi

