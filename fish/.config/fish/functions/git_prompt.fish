#!/usr/bin/env fish

source ~/.config/fish/functions/solarized_colors_def.fish

# configure git prompt
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch $COLOR_SOLARIZED_MAGENTA
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_char_upstream_ahead "↑ "
set -g __fish_git_prompt_char_upstream_behind "↓ "
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "● "
set -g __fish_git_prompt_char_dirtystate "✚ "
set -g __fish_git_prompt_char_untrackedfiles "… "
set -g __fish_git_prompt_char_conflictedstate "✖ "
set -g __fish_git_prompt_char_cleanstate "✔ "

set -g __fish_git_prompt_color_dirtystate $COLOR_SOLARIZED_BLUE
set -g __fish_git_prompt_color_stagedstate $COLOR_SOLARIZED_YELLOW
set -g __fish_git_prompt_color_invalidstate $COLOR_SOLARIZED_RED
set -g __fish_git_prompt_color_untrackedfiles $COLOR_SOLARIZED_BASE01
set -g __fish_git_prompt_color_cleanstate $COLOR_SOLARIZED_GREEN
# end configure git prompt

# configure async git prompt
set -U async_prompt_functions fish_vcs_prompt
# end configure async git prompt
