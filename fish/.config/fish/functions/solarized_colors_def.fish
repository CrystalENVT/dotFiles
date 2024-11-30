#!/usr/bin/env fish

# Define Solarized colors for easy use later
set -g COLOR_SOLARIZED_BASE03  "002b36"
set -g COLOR_SOLARIZED_BASE02  "073642"
set -g COLOR_SOLARIZED_BASE01  "586e75"
set -g COLOR_SOLARIZED_BASE00  "657b83"
set -g COLOR_SOLARIZED_BASE0   "839496"
set -g COLOR_SOLARIZED_BASE1   "93a1a1"
set -g COLOR_SOLARIZED_BASE2   "eee8d5"
set -g COLOR_SOLARIZED_YELLOW  "b58900"
set -g COLOR_SOLARIZED_ORANGE  "cb4b16"
set -g COLOR_SOLARIZED_RED     "dc322f"
set -g COLOR_SOLARIZED_MAGENTA "d33682"
set -g COLOR_SOLARIZED_VIOLET  "6c71c4"
set -g COLOR_SOLARIZED_BLUE    "268bd2"
set -g COLOR_SOLARIZED_CYAN    "2aa198"
set -g COLOR_SOLARIZED_GREEN   "859900"

# Set LS_COLORS to match Solarized Dark
eval (dircolors --c-shell ~/.dircolors/dircolors.solarized-ansi-dark)
