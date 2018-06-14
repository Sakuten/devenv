#!/usr/bin/env bash

function box_out()
{
  local s="$*"
  tput setaf 3
  echo " -${s//?/-}-
| ${s//?/ } |
| $(tput setaf 2)$s$(tput setaf 3) |
| ${s//?/ } |
 -${s//?/-}-"
  tput sgr 0
}

message="$1"
shift

for host in "$@"
do
  wait-for-it $host -t 0
done

box_out $message
