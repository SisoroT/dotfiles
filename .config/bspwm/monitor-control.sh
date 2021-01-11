#!/bin/sh

monitors=$(xrandr | grep -sw 'connected' | cut -d " " -f 1)

layout_laptop_only() {
  bspc monitor -d I II III IV V VI VII VIII IX X
}

layout_external() {
  bspc monitor eDP-1 -d I II III IV V
  bspc monitor HDMI-1-0 -d VI VII VIII IX X
}

for m in $monitors
do
  if [[ "$m" == "HDMI-1-0" ]]; then
    layout_external
  else
    layout_laptop_only
  fi
done
