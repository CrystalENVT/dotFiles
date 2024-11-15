#!/usr/bin/env fish

# set greeting message, currently no text, but run fisher components once
function fish_greeting
    # Check if fisher is installed, if not, install it. Only needed once per machine, but nice to have
    if not type -q fisher
        echo "Fisher is not installed. Installing it along with expected packages (!! & async_prompt)"
        begin
            curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
            # ^^ fisher install vv fisher plugins install, alphabetical order
            fisher install acomagu/fish-async-prompt
            fisher install jethrokuan/z
            fisher install jichu4n/fish-command-timer
            fisher install jihchi/jq-fish-plugin
            fisher install jorgebucaran/autopair.fish
            fisher install oh-my-fish/plugin-bang-bang
            fisher install reitzig/sdkman-for-fish
        end | grep Installing --color=NEVER
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

# set solarized dark theme before other customizations
fish_config theme choose "Solarized Dark"

# don't use default timer printing info
set fish_command_timer_enabled 0

#source custom git_prompt configuration for the fish_prompt
source ~/.config/fish/functions/git_prompt.fish

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
    # skobeloff previous command duration
    printf "%s%s " (set_color 007474) $CMD_DURATION_STR
    # "normal" username
    printf "%s%s:" (set_color $user_color) $USER
    # colored cwd & git info & final prompt character
    printf "%s%s%s%s%s " (set_color $fish_color_cwd) (prompt_pwd --full-length-dirs=2 --dir-length=1) (set_color normal) (fish_vcs_prompt) $PROMPT_CHAR
end

# Commands to run in interactive sessions
if status is-interactive
    # setup commands with expected behaviour
    abbr rm "rm -i"
end

set -g MANPAGER "less -R --use-color -Dd+r -Du+b"

set -g __sdkman_custom_dir ~/.sdkman

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
