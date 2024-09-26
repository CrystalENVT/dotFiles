# set greeting message, currently disabled
set fish_greeting

# thefuck typo helper init, provides the command "fuck"
if type -q thefuck
    thefuck --alias | source
end

# configure git prompt
set -g __fish_git_prompt_show_informative_status true
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream "informative"
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
    # Check if fisher is installed, if not, install it. Only needed once per machine, but nice to have
    if not type -q fisher
        echo "Fisher is not installed. Installing it along with expected packages (!! & async_prompt)"
        curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
	    fisher install oh-my-fish/plugin-bang-bang
	    fisher install acomagu/fish-async-prompt
		fisher install jorgebucaran/autopair.fish
		fisher install jethrokuan/z
    end	
	
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd $fish_color_cwd
        end
        set PROMPT_CHAR '#'
    else
        set color_cwd $fish_color_cwd
        set PROMPT_CHAR '$'
    end
    # prompt in format of:
    # TIME Username:cwd (git prompt)$

    # teal current time
    printf "%s%s%s " (set_color 2BC) (date +%H:%M:%S) (set_color normal)
    # "normal" username
    printf "%s:" $USER
    # colored cwd & git info & final prompt character
    printf "%s%s%s%s%s " (set_color $fish_color_cwd) (prompt_pwd --full-length-dirs=2 --dir-length=1) (set_color normal) (fish_vcs_prompt) $PROMPT_CHAR
end

# Commands to run in interactive sessions
if status is-interactive

end

# Set default editor
set -gx EDITOR "emacs"

# setup commands with expected behaviour
alias rm "rm -i"

# "Obvious" abbreviations, alphabetically
abbr . "source ~/.config/fish/config.fish"
abbr .. "cd .."
abbr c "clear"
abbr cfg_fish "$EDITOR ~/.config/fish/config.fish"
abbr conf_fish "$EDITOR ~/.config/fish/config.fish"
abbr rels "ls | grep -i"
abbr t "tmux attach -t"
abbr untar "tar -xvf"

# set clipboard based upon the contents of a file
if type xclip &> /dev/null
    abbr setclip "xclip -selection c"
end

# Prune removed remote branches from local git
abbr clean_git "git fetch --all -p; git branch -vv | grep \": gone]\" | awk '{ print \$1 }' | xargs -n 1 git branch -d"

### WORK STUFF BELOW HERE ###

source ~/.config/fish/functions/work.fish