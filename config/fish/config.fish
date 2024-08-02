abbr -a e nvim
abbr -a cp 'cp -v'
abbr -a mv 'mv -v'
abbr -a mkdir 'mkdir -p'

abbr -a z zellij

abbr -a g git
abbr -a ga 'git add -p'
abbr -a gco 'git checkout'
abbr -a gcm 'git commit'
abbr -a gp 'git push'
abbr -a gs 'git status -s'
abbr -a gr 'git restore'
abbr -a gds 'git diff --staged'
abbr -a grs 'git restore --staged'
abbr -a grh 'git reset --hard'
abbr -a gl 'git log'
abbr -a glg 'git log --oneline --graph'
abbr -a vim 'vim -i NONE'

if command -v zathura >/dev/null
    abbr -a zat zathura
end

if command -v neorg >/dev/null
    abbr -a notes "neorg ~/Notes"
end

if command -v eza >/dev/null
    abbr -a ls 'eza -l --icons --group-directories-first'
    abbr -a ll 'eza -la --icons --group-directories-first'
else
    abbr -a ls 'ls -l'
    abbr -a ll 'ls -la'
end

fish_add_path '/home/rg/.scripts'
fish_add_path '/home/rg/.local/bin'
fish_add_path '/home/rg/.local/share/cargo/bin'
fish_add_path '/home/rg/.local/share/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin'

set -x EDITOR nvim
set -x VISUAL nvim
set -x BROWSER firefox
set -x TERMINAL alacritty
set -x READER zathura
set -x PAGER less

set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_DATA_HOME "$HOME/.local/share"
set -x XDG_CACHE_HOME "$HOME/.cache"

set -x WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"
set -x AUDACITY_PATH "$XDG_CONFIG_HOME/Audacity"

set -x GNUPGHONE "$XDG_DATA_HOME/gnupg"
set -x CARGO_HOME "$XDG_DATA_HOME/cargo"
set -x RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -x GEM_HOME "$XDG_DATA_HOME/gems"
set -x HISTFILE "$XDG_DATA_HOME/bash_history"
set -x PSQL_HISTORY "$XDG_DATA_HOME/psql_history"
set -x NUGET_PACKAGES "$XDG_DATA_HOME/NuGet/packages"
set -x WINEPREFIX "$XDG_DATA_HOME/wine"

set -x QT_SCALE_FACTOR 1.5
# this breaks multimc on x11 (and probably other qt apps as well)
# set -x QT_QPA_PLATFORM=wayland

set -x LESSHISTFILE -
set -x NODE_REPL_HISTORY ""
set -x XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
set -x LC_COLLATE C

set -x NNN_OPTS doeA

set -x _JAVA_AWT_WM_NONREPARENTING 1
set -x _JAVA_OPTIONS "-Dawt.useSystemAAFontSettings=on"

set -x XKB_DEFAULT_LAYOUT "us,hu"
set -x XKB_DEFAULT_VARIANT "basic,102_qwerty_dot_nodead"
set -x XKB_DEFAULT_OPTIONS "caps:escape"

set -x BEMENU_OPTS "-f --binding vim --vim-esc-exits --ignorecase \
  --single-instance --fixed-height -l 10 --no-overlap --monitor HDMI-A-1 \
  --tb $ROSEPINE_MAIN_OVERLAY --tf $ROSEPINE_MAIN_TEXT \
  --fb $ROSEPINE_MAIN_OVERLAY --ff $ROSEPINE_MAIN_FOAM \
  --nb $ROSEPINE_MAIN_OVERLAY --nf $ROSEPINE_MAIN_TEXT \
  --hb $ROSEPINE_MAIN_LOVE --hf $ROSEPINE_MAIN_OVERLAY \
  --sb $ROSEPINE_MAIN_GOLD --sf $ROSEPINE_MAIN_OVERLAY \
  --ab $ROSEPINE_MAIN_SURFACE --af $ROSEPINE_MAIN_TEXT \
  -W 0.4"
set -x BEMENU_SCALE 1.5

set __fish_git_prompt_showuntr yes
set __fish_git_prompt_showdirtystate yes
set __fish_git_prompt_showcolorhints yes

if command -v fd >/dev/null
    set -x FZF_DEFAULT_COMMAND "fd --type f"
else if command -v fdfind >/dev/null
    set -x FZF_DEFAULT_COMMAND "fdfind --type f"
end

set -x FZF_DEFAULT_OPTS "--bind j:down,k:up,space:toggle --bind 'start:unbind(j)+unbind(k)+unbind(i)'" \
    "--bind 'esc:rebind(j)+rebind(k)+rebind(i)+change-prompt([NORMAL] > )'" \
    "--bind 'i:unbind(j)+unbind(k)+unbind(i)+change-prompt([INSERT] > )'" \
    "--prompt '[INSERT] > ' --ansi"

if status is-interactive
    fish_config theme choose "Rosé Pine Moon"
    fish_vi_key_bindings
    bind -M insert -k nul accept-autosuggestion # ctrl-space
    bind -M insert \t complete-and-search
    bind -M visual \t complete-and-search
    bind -M insert \n down-line
    bind -M insert \v up-line
    set fzf_history_opts --preview=""
    zoxide init fish --cmd cd | source

    set -x XDG_CURRENT_DESKTOP Hyprland
    if test (tty) = /dev/tty1
        set -x KYRIA=0
        exec Hyprland
    end


    if test (tty) = /dev/tty2
        set -x KYRIA=0
        exec startx -- -keeptty $DISPLAY -ardelay 250 -arinterval 20 &>/dev/null
    end
end
