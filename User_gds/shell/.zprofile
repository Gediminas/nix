# if test (id --user $USER) -ge 1000"
if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then
  export MOZ_ENABLE_WAYLAND=1
  exec sway
fi

