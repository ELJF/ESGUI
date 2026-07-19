#!/bin/bash

WORK_PATH="$(cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd)"
cd "$WORK_PATH"

echo ""
echo "      Uart Download"
echo ""

input=""
if [ $# -gt 0 ]; then
  case "$1" in
    -p|--port)
      shift
      input="${1:-}"
      ;;
    *)
      input="$1"
      ;;
  esac
fi

if [ -n "$input" ]; then
  # Port provided as argument
  echo "Using port from args: $input"
else
  # If no port is specified, enumerate available ports
  ports=()
  unameOut="$(uname)"
  if [ "$unameOut" = "Darwin" ]; then
    for p in /dev/cu.*; do
      if [ -e "$p" ] && echo "$p" | grep -qi "usb"; then
        ports+=("$p")
      fi
    done
  elif [ "$unameOut" = "Linux" ]; then
    for p in /dev/ttyUSB* /dev/ttyACM*; do
      [ -e "$p" ] && ports+=("$p")
    done
  else
    echo "Unsupported OS: $unameOut"
    exit 1
  fi

  if [ "${#ports[@]}" -gt 0 ]; then
    echo "Available serial ports:"
    for i in "${!ports[@]}"; do
      printf "  [%d] %s
" "$i" "${ports[$i]}"
    done
  else
    echo "No ports auto-detected."
  fi

  read -r -p "Enter index OR type a port (e.g. /dev/ttyUSB0): " sel
  if [[ "$sel" =~ ^[0-9]+$ ]] && [ "$sel" -ge 0 ] && [ "$sel" -lt "${#ports[@]}" ]; then
    # Index provided
    input="${ports[$sel]}"
  else
    # Assume direct port input, the old way
    input="$sel"
  fi
fi

echo "$input"

sftool -p "$input" -c SF32LB52 -m nor write_flash "bootloader\bootloader.bin@0x12010000" "main.bin@0x12020000" "ftab\ftab.bin@0x12000000"

