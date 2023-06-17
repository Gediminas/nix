d=$(dunstctl count displayed)
h=$(dunstctl count history)
w=$(dunstctl count waiting)
a=$((w+h+d))

# d="1"
# h="0"
# w="5"

# echo -n " a "
# [ ! "$w" = "0" ] && echo -n " w${w} "
if [ "$a" = "0" ]; then
  echo -n ""
else
  if [ "$d" = "0" ]; then
    echo -n "<span color='#FFFFFF' background='#550055'> ${a} </span>"
  else
    echo -n "<span color='#FFFFFF' background='#550055'> ${d}/${a} </span>"
  fi
fi
