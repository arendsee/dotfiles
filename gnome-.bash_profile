#
# ~/.bash_profile
#

# Clock settings
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-date true

# Turning off animations
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.nautilus.desktop background-fade false
gsettings set org.gnome.desktop.wm.preferences audible-bell false
gsettings set org.gnome.desktop.wm.preferences visual-bell false

# Turning off desktop icons
gsettings set org.gnome.nautilus.desktop home-icon-visible false
gsettings set org.gnome.nautilus.desktop trash-icon-visible false
gsettings set org.gnome.nautilus.desktop network-icon-visible false
gsettings set org.gnome.nautilus.preferences show-hidden-files true

# Getting rid of bars
gsettings set org.gnome.desktop.interface toolbar-style 'both-horiz'
gsettings set org.gnome.desktop.interface toolbar-icons-size 'small'
gsettings set org.gnome.nautilus.window-state start-with-location-bar false
gsettings set org.gnome.nautilus.window-state start-with-sidebar false
gsettings set org.gnome.Evince.Default show-sidebar false

# Setting up workspaces
gsettings set org.gnome.desktop.wm.preferences num-workspaces 9
# The shell eats one level of quotes ...
gsettings set org.gnome.shell.keybindings toggle-application-view ["'<Ctrl><Shift>a'"]
gsettings set org.gnome.shell.keybindings toggle-overview ["'<Ctrl><Shift>s'"]
gsettings set org.gnome.desktop.wm.keybindings panel-main-menu ["'<Alt>F1'"]
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 ['"<Super>q"']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 ['"<Super>w"']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 ['"<Super>e"']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 ['"<Super>a"']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 ['"<Super>s"']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 ['"<Super>d"']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7 ['"<Super>z"']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8 ['"<Super>x"']
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9 ['"<Super>c"']
# Move items between workspaces
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right ['"<Control><Shift><Alt>l"']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up ['"<Control><Shift><Alt>k"']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left ['"<Control><Shift><Alt>h"']
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down ['"<Control><Shift><Alt>j"']


[[ -f ~/.bashrc ]] && . ~/.bashrc
