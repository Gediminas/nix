#!/usr/bin/env bash

nr=0
while true
do
  nr=$(($nr+1))
  # notify-desktop "$(date) test-$nr"
  dunstify -h string:x-dunst-stack-tag:test "$(date '+%H:%M:%S') Test" -A 'tested,default'
date "+%H:%M:%S"
date "+%H:%M:%S"

  sleep 5
done