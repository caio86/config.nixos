{ pkgs, ... }:

{
  programs.tmux.enable = true;
  programs.tmux.extraConfig = ''
    # Set true color
    set-option -sa terminal-overrides ",xterm*:Tc"
    set -sg escape-time 1
    
    # Enable mouse
    set -g mouse on
    
    # Set prefix
    unbind C-b
    set -g prefix C-a
    bind C-a send-prefix
    
    # Bind Shift Alt vim keys to switch windows
    bind -n M-H previous-window
    bind -n M-L next-window
    
    # Start windows and panes at 1, not 0
    set -g base-index 1
    set -g pane-base-index 1
    set-window-option -g pane-base-index 1
    set-option -g renumber-windows on
    
    ###########
    # Plugins #
    ###########
    
    set -g @catppuccin_flavour 'mocha'
    
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'christoomey/vim-tmux-navigator'
    set -g @plugin 'catppuccin/tmux'
    set -g @plugin 'tmux-plugins/tmux-yank'
    set -g @plugin 'tmux-plugins/tmux-resurrect'
    set -g @plugin 'tmux-plugins/tmux-continuum'
    
    ##########
    # Config #
    ##########
    
    # window format
    set -g status-position top
    set -g @catppuccin_window_left_separator "█"
    set -g @catppuccin_window_right_separator "█ "
    set -g @catppuccin_window_number_position "left"
    set -g @catppuccin_window_middle_separator " | "
    set -g @catppuccin_window_status_enable "yes"
    set -g @catppuccin_window_status_icon_enable "yes"
    
    # window default format
    set -g @catppuccin_window_default_fill "none"
    # set -g @catppuccin_window_default_text "#( echo \#{pane_current_path} | sed \"s|$HOME|~|\" | xargs basename )"
    set -g @catppuccin_window_default_text "#(if [ \#W = "zsh" ]; then echo \#{pane_current_path} | sed \"s|$HOME|$HOME|\" | xargs basename; else echo \#W; fi )"
    
    # window current format
    set -g @catppuccin_window_current_fill "all"
    # set -g @catppuccin_window_current_text "#( echo \#{pane_current_path} | sed \"s|$HOME|~|\" )"
    set -g @catppuccin_window_current_text "#( echo \#{pane_current_path} | sed \"s|$HOME|$HOME|\" | xargs basename )"
    
    # status modules list
    # set -g @catppuccin_status_modules "application session battery host date_time"
    set -g @catppuccin_status_modules_right "application session date_time"
    set -g @catppuccin_status_left_separator "█"
    set -g @catppuccin_status_right_separator "█"
    set -g @catppuccin_status_right_separator_inverse "no"
    set -g @catppuccin_status_fill "icon"
    set -g @catppuccin_status_connect_separator "yes"
    
    # config for host module
    set -g @catppuccin_host_text "#(whoami)@#h"
    
    # config for date_time module
    set -g @catppuccin_date_time_text "%Y-%m-%d | %H:%M:%S"
    
    # set vi-mode
    set-window-option -g mode-keys vi
    
    ###############
    # keybindings #
    ###############
    
    # Open todo file
    bind -r T neww -c "#{pane_current_path}" "[[ -e TODO.md ]] && nvim TODO.md || nvim ~/todo.md"
    # copy-mode-vi
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
    bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
    
    bind-key -r i run-shell "tmux neww tmux-cht.sh"
    bind-key -r f run-shell "tmux neww tmux-navigator"
    # bind-key -r F run-shell "tmux-windowizer"
    
    # Open panes in current directory
    bind '"' split-window -v -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"
    bind c neww -c "#{pane_current_path}"
    
    # bootstrap tpm
    if "test ! -d ~/.config/tmux/plugins/tpm" \
      "run 'git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm'"
    
    # Initialize tmux plugin manager
    run '~/.config/tmux/plugins/tpm/tpm'
  '';
}
