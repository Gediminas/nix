#!/usr/bin/env bash

NET_INTERFACE="${1:-wlp0s20f3}"
PROC_NET_DEV=/proc/net/dev
TMP_NET_PREV=/tmp/.net_${NET_INTERFACE}_traffic
TMP_NET_PING=/tmp/.net_${NET_INTERFACE}_ping

echo_html_value () {
  level=$1
  kbps=$2
  symbol=$3

  case $1 in
    0|1|2) color='#0077FF' ;;# .008  .080  .800 kb/s
    3|4) color='#00BBFF' ;;  # 8.0  80.0 kb/s
    5) color='#FFFF00' ;;    # 800.0 kb/s
    6) color='#FF7700' ;;    # 8.0 Mb/s
    *) color='#FF0000' ;;    # 80.0  800.0  8000.0 ... Mb/s
  esac

  case $level in
    0|1|2)
      # .008  .080  .800 kb/s
      value=$(echo "scale=3; $kbps / 1000" | bc)
      units="k"
      ;;
    3|4|5)
      # 8.0  80.0  800.0 kb/s
      value=$(echo "scale=1; $kbps / 1000" | bc)
      units="k"
      ;;
    *)
      # 8.0  80.0  800  8000 ... Mb/s
      value=$(echo "scale=1; $kbps / 1000000" | bc)
      units="M"
      ;;
  esac

  #echo -n "<span font='8' color='#FFFFFF'>L$level </span>"
  #echo -n "<span color='$color'>${value} ${units}<span font='16'>$symbol</span></span>"
  printf "<span color='%s'>%5.1f%s<span font='12'>%s</span></span>" $color $value $units $symbol
}

echo_human_value() {
  symbol=$1
  bytes1=$2
  bytes2=$3
  time_ms=$4
  bits=$(( ($bytes2 - $bytes1) * 8 ))
  kbps=$(echo "scale=0; 1000.0 * $bits / $time_ms" | bc)
  level=$(echo "if ($kbps == 0) x = 0 else x=l($kbps)/l(10); scale = 0; x / 1" | bc -l)
  echo_html_value $level $kbps $symbol
}


#Workaround: > makes file empty first, and no value is read later
(ping -c 1 1.0.0.1 | awk -F '/' 'END {print $5}' >> $TMP_NET_PING) &

# Read prev values from /tmp/net
while read tm rx tx; do
  prev_tm=$tm; prev_rx=$rx; prev_tx=$tx
done < $TMP_NET_PREV

# Get new values and save to /tmp/net
curr_tm=$(date +%s%3N)
curr_rx=$(cat $PROC_NET_DEV | grep $NET_INTERFACE | awk '{print $2}')
curr_tx=$(cat $PROC_NET_DEV | grep $NET_INTERFACE | awk '{print $10}')
echo $curr_tm $curr_rx $curr_tx > $TMP_NET_PREV

##########################################
# Print speeds (if iface has data)

[ "$curr_rx" == "" ] && exit 0
[ "$curr_tx" == "" ] && exit 0
# [ "${NET_INTERFACE[0]:0:1}" != "w" ] && echo -n "${NET_INTERFACE[0]:0:1}:" #Print iface[0] if not wifi

diff_tm_ms=$(( ($curr_tm-$prev_tm) ))
echo_human_value ↓ $prev_rx $curr_rx $diff_tm_ms
echo_human_value ↑ $prev_tx $curr_tx $diff_tm_ms


##########################################
# Print ping time (if this is default route)

VIA_IFACE=$(route | grep default | head -n1 | awk '{print $8}')
[ "$VIA_IFACE" != "$NET_INTERFACE" ] && exit 0

sleep 0.5
png=$(tail -1 $TMP_NET_PING)
if [ "$png" = "" ]; then
  printf "<span color='green'> --</span>\n" $png
else
  printf "<span color='green'>%3.0f</span>\n" $png
  echo "" > $TMP_NET_PING
fi
