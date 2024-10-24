#!/usr/bin/env fish

# set greeting message, currently no text, but run fisher components once
function fish_greeting
    # Check if fisher is installed, if not, install it. Only needed once per machine, but nice to have
    if not type -q fisher
        echo "Fisher is not installed. Installing it along with expected packages (!! & async_prompt)"
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
        # ^^ fisher install vv fisher plugins install, alphabetical order
        fisher install acomagu/fish-async-prompt | grep Installing
        fisher install jethrokuan/z | grep Installing
        fisher install jihchi/jq-fish-plugin | grep Installing
        fisher install jorgebucaran/autopair.fish | grep Installing
        fisher install oh-my-fish/plugin-bang-bang | grep Installing
        # set temporary file for checking if an update should run later
        touch /tmp/crystal_fisher_update_timestamp
    else
        if test ! -f /tmp/crystal_fisher_update_timestamp
            touch -d $(date --date="2 days ago") /tmp/crystal_fisher_update_timestamp
        end
        set fisher_update_timestamp (date +%s -r /tmp/crystal_fisher_update_timestamp)
        set one_day_ago (date +%s --date="1 day ago")
        if [ $fisher_update_timestamp -lt $one_day_ago ]
            echo "Updating fisher & plugins..."
            # silence update details except for info
            fisher update | grep --invert-match Fetching | grep --ignore-case --color=NEVER update
            touch /tmp/crystal_fisher_update_timestamp
        end
    end
end

# thefuck typo helper init, provides the command "fuck"
if type -q thefuck
    thefuck --alias | source
end

# configure git prompt
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream informative
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green
# end configure git prompt

# configure async git prompt
set -U async_prompt_functions fish_vcs_prompt
# end configure async git prompt

# setup shell prompt
function fish_prompt -d "Write out the prompt"

    if functions -q fish_is_root_user; and fish_is_root_user
        set user_color brred
        set PROMPT_CHAR '#'
    else
        set user_color normal
        set PROMPT_CHAR '$'
    end
    # prompt in format of:
    # TIME Username:cwd (git prompt)$

    # teal current time
    printf "%s%s " (set_color 2BC) (date +%H:%M:%S)
    # "normal" username
    printf "%s%s:" (set_color $user_color) $USER
    # colored cwd & git info & final prompt character
    printf "%s%s%s%s%s " (set_color $fish_color_cwd) (prompt_pwd --full-length-dirs=2 --dir-length=1) (set_color normal) (fish_vcs_prompt) $PROMPT_CHAR
end

# Commands to run in interactive sessions
if status is-interactive

end

# add locally installed binaries to path
fish_add_path ~/.local/bin/

# connect to emacs daemon, or create a new session
alias emacs "emacs --maximized"

# Set default editor
set -gx EDITOR emacs
set -gx SUDO_EDITOR "emacs --maximized"

# we need to override sudo to allow emacs to launch maximized via "sudo emacs"
function sudo --wraps sudo --description "sudo but set emacs fullscreen"
    if [ $argv[1] = "emacs" ]
        /usr/bin/sudo emacs --maximized $argv[2..-1]
    else
        /usr/bin/sudo $argv
    end
end

if test -e $HOME/.config/emacs/bin
    alias doom $HOME/.config/emacs/bin/doom
    abbr cfg_doom_config "emacs ~/.config/doom/config.el"
    abbr cfg_doom_init "emacs ~/.config/doom/init.el"
    abbr conf_doom_init "emacs ~/.config/doom/config.el"
    abbr conf_doom_init "emacs ~/.config/doom/init.el"
end

# setup commands with expected behaviour
alias rm "rm -i"

# "Obvious" abbreviations, alphabetically
abbr . "source ~/.config/fish/config.fish"
abbr .. "cd .."
abbr c clear
abbr cfg_fish "$EDITOR ~/.config/fish/config.fish"
abbr conf_fish "$EDITOR ~/.config/fish/config.fish"
abbr rels "ls | grep -i"
abbr t "tmux attach -t"
abbr untar "tar -xvf"

# set clipboard based upon the contents of a file
if type xclip &>/dev/null
    abbr setclip "xclip -selection c"
end

# Prune removed remote branches from local git
abbr clean_git "git fetch --all -p; git branch -vv | grep \": gone]\" | awk '{ print \$1 }' | xargs -n 1 git branch -D"

### WORK STUFF BELOW HERE ###

if test -e $HOME/.config/fish/functions/work.fish
    source $HOME/.config/fish/functions/work.fish
end
