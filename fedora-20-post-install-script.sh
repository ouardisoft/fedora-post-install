#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Sam Hewitt <hewittsamuel@gmail.com>
#
# Description:
#   A post-installation bash script for Fedora (13.10)
#
# Legal Stuff:
#
# This script is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 3.
#
# This script is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

echo ''
echo '#----------------------------------------#'
echo '#     Fedora 20 Post-Install Script      #'
echo '#----------------------------------------#'

#----- FUNCTIONS -----#

# SYSTEM UPGRADE
function sysupgrade {
# Perform system upgrade
echo ''
read -p 'Proceed with system update? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* )
    # Update repository information
    echo 'Performing system update...'
    echo 'Requires root privileges:'
    sudo yum update -y
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* )
    clear && main
    ;;
# Error
* )
    clear && echo 'Sorry, try again.'
    sysupgrade
    ;;
esac
}

# INSTALL APPLICATIONS
function favourites {
# Install Favourite Applications
echo ''
echo 'Installing selected favourite applications...'
echo ''
echo 'Current package list:
cheese
darktable
easytag
filezilla
gnome-maps
gnome-tweak-tool
gnome-online-accounts
gnome-weather
gpick
grsync
nautilus-open-terminal
pyrenamer
sparkleshare
xchat
vlc
wget'
echo ''
read -p 'Proceed? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* ) 
    echo 'Requires root privileges:'
    # Feel free to change to whatever suits your preferences.
    sudo yum install -y cheese darktable easytag filezilla gnome-maps gnome-online-accounts gnome-tweak-tool gnome-weather gpick grsync nano nautilus-open-terminal pyrenamer sparkleshare xchat vlc wget
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* )
    clear && main
    ;;
# Error
* )
    clear && echo 'Sorry, try again.'
    favourites
    ;;
esac
}

# INSTALL SYSTEM TOOLS
function system {
# Install Favourite System utilities
echo 'Installing favourite system utilities...'
echo ''
echo 'Current package list:
dconf-editor
java
openssh-server
samba
supybot
symlinks
virt-manager
xorg-x11-apps.x86_64'
echo ''
read -p 'Proceed? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* )
    echo 'Requires root privileges:'
    # Feel free to change to whatever suits your preferences.
    sudo yum install -y dconf-editor java-*-openjdk openssh-server samba supybot symlinks virt-manager xorg-x11-apps.x86_64
    echo 'Done.'
    clear && main
    ;;
# Negative action
[Nn]* )
    clear && main
    ;;
# Error
* )
    clear && echo 'Sorry, try again.'
    main
    ;;
esac
}


# INSTALL DEVELOPMENT TOOLS
function development {
# Install Development Tools
echo 'Installing development tools...'
echo ''
echo 'Current package list:
bzr
devscripts
git
glade
gnome-common
python3-distutils-extra
ruby'
echo ''
read -p 'Proceed? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* ) 
    echo 'Requires root privileges:'
    # Feel free to change to whatever suits your preferences.
    sudo yum install -y bzr devscripts git glade gnome-common python3-distutils-extra ruby
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* )
    clear && main
    ;;
# Error
* )
    clear && echo 'Sorry, try again.'
    main
    ;;
esac
}

# INSTALL DESIGN TOOLS
function design {
echo ''
echo 'Installing design tools...'
echo ''
echo 'Current package list:
fontforge
gimp
ImageMagick
inkscape'
echo ''
read -p 'Proceed? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* ) 
    echo 'Requires root privileges:'
    # Feel free to change to whatever suits your preferences.
    sudo yum install -y fontforge gimp ImageMagick inkscape
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* ) 
    clear && main;;
# Error
* )
    clear && echo 'Sorry, try again.' && design
    ;;
esac
}

# THIRD PARTY REPOS
function repos {
echo 'Which repositories would you like to enable? '
echo ''
echo '1. RPM Fusion?'
echo 'r. Return'
echo ''
read -p 'Enter your choice: ' REPLY
case $REPLY in
# RPM Fusion
1)
    # Add repository
    echo 'Adding RPM Fusion to repositories...'
    echo 'Requires root privileges:'
    su -c 'yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
    echo 'Done.'
    # Update system
    echo 'Updating system...'
    sudo yum update -y 
    echo 'Done'
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && repos;;
esac
}

# INSTALL SUBLIME TEXT 3
function sublime3 {
# Downloading Sublime Text 3
cd $HOME/Downloads
echo 'Downloading Sublime Text 3 (build 3047)...'
# Download tarball that matches system architecture
if [ $(uname -i) = 'i386' ]; then
    wget http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3047.tar.bz2
elif [ $(uname -i) = 'x86_64' ]; then
    wget http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3047_x64.tar.bz2
fi
# Extract Tarball
cd $HOME/Downloads
echo 'Extracting Sublime Text 3 (build 3047)...'
tar xf sublime*.tar.bz2
# Move Sublime Text 3 to /opt
echo 'Installing...'
echo 'Requires root privileges:'
if [ -d /opt/sublime_text_3 ]; then
    echo
    read -p "Found an existing installation. Replace it? (Y)es, (N)o : " INPUT
    case $INPUT in
        [Yy]* ) 
            sudo rm -Rf /opt/sublime_text_3 2>/dev/null
            sudo mv sublime_text_3 /opt/
            ;;
        [Nn]* ) echo 'Okay, cancelling' && thirdparty;;
        * )
        clear && echo 'Sorry, try again.'
        thirdparty
        ;;
    esac
fi
echo 'Done.'
# Create symbolic link
echo 'Creating symbolic link...'
echo 'Requires root privileges:'
sudo ln -sf /opt/sublime_text_3/sublime_text /usr/bin/sublime
echo 'Done.'
# Create .desktop file
echo 'Setting up installation:'
echo 'Creating .desktop file...'
echo "[Desktop Entry]
Version=3
Name=Sublime Text 3
GenericName=Text Editor
 
Exec=sublime
Terminal=false
Icon=sublime-text
Type=Application
Categories=TextEditor;IDE;Development
X-Ayatana-Desktop-Shortcuts=NewWindow

[NewWindow Shortcut Group]
Name=New Window
Exec=sublime -n" >> sublime-text.desktop
# Move .desktop file
echo 'Moving .desktop file to /usr/share/applications'
sudo mv -f sublime-text.desktop /usr/share/applications/
echo 'Done.'
# Install icon
echo 'Copying icons...'
sudo cp -r /opt/sublime_text_3/Icon/16x16/* /usr/share/icons/hicolor/16x16/apps
sudo cp -r /opt/sublime_text_3/Icon/32x32/* /usr/share/icons/hicolor/32x32/apps
sudo cp -r /opt/sublime_text_3/Icon/48x48/* /usr/share/icons/hicolor/48x48/apps
sudo cp -r /opt/sublime_text_3/Icon/128x128/* /usr/share/icons/hicolor/128x128/apps
sudo cp -r /opt/sublime_text_3/Icon/256x256/* /usr/share/icons/hicolor/256x256/apps
sudo gtk-update-icon-cache /usr/share/icons/hicolor
echo 'Done.'
# Cleanup & finish
rm sublime*.tar.bz2
cd
echo ''
echo 'Installation of Sublime Text 3 complete.'
thirdparty
}

# THIRD PARTY APPLICATIONS
function thirdparty {
echo 'What would you like to install? '
echo ''
echo '1. Google Chrome?'
echo '2. Google Talk Plugin?'
echo '3. Google Music Manager?'
echo '4. Dropbox?'
echo '5. Sublime Text 3 (build 3047)?'
echo 'r. Return'
echo ''
read -p 'Enter your choice: ' REPLY
case $REPLY in
# Google Chrome
1) 
    echo 'Downloading Google Chrome...'
    # Download RPM file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.rpm
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    fi
    # Install package(s)
    echo 'Installing Google Chrome...'
    echo 'Requires root privileges:'
    sudo yum --nogpgcheck localinstall -y google-chrome*.rpm
    # Cleanup and finish
    rm google-chrome*.rpm
    cd
    echo 'Done.'
    thirdparty
    ;;
# Google Talk Plugin
2)
    echo 'Downloading Google Talk Plugin...'
    # Download RPM file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_i386.rpm
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_x86_64.rpm
    fi
    # Install package(s)
    echo 'Installing Google Talk Plugin...'
    echo 'Requires root privileges:'
    sudo yum --nogpgcheck localinstall -y google-talkplugin_current*.rpm
    # Cleanup and finish
    rm google-talkplugin_current*.rpm
    cd
    echo 'Done.'
    thirdparty
    ;;
# Google Music Manager
3)
    echo 'Downloading Google Music Manager...'
    # Download RPM file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-musicmanager-beta_current_i386.rpm
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-musicmanager-beta_current_x86_64.rpm
    fi
    # Install package(s)
    echo 'Installing Google Music Manager...'
    echo 'Requires root privileges:'
    sudo yum --nogpgcheck localinstall -y google-musicmanager-*.rpm
    # Cleanup and finish
    rm google-musicmanager*.rpm
    cd
    echo 'Done.'
    thirdparty
    ;;
# Dropbox
4)
    echo 'Downloading Dropbox...'
    # Download RPM file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-1.6.0-1.fedora.i386.rpm
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://www.dropbox.com/download?dl=packages/fedora/nautilus-dropbox-1.6.0-1.fedora.x86_64.rpm
    fi
    # Install package(s)
    echo 'Installing Dropbox...'
    echo 'Requires root privileges:'
    sudo yum --nogpgcheck localinstall -y nautilus-dropbox-*.rpm
    # Cleanup and finish
    rm nautilus-dropbox-*.rpm
    cd
    echo 'Done.'
    thirdparty
    ;;
# Sublime Text 3
5)
    sublime3
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && thirdparty;;
esac
}

# THIRD PARTY DRIVERS
function drivers {
echo 'What would you like to install? '
echo ''
echo '1. Broadcom wireless drivers (kmod-wl).'
echo 'r. Return'
echo ''
read -p 'Enter your choice: ' REPLY
case $REPLY in
# Google Chrome
1) 
    echo 'Requires RPM Fusion repository'
    # Add repository
    echo 'Adding RPM Fusion to repositories...'
    echo 'Requires root privileges:'
    su -c 'yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
    echo 'Done.'
    # Update system
    echo 'Updating system...'
    sudo yum -y update
    echo 'Done'
    echo 'Installing Broadcom wireless drivers...'
    sudo yum install -y kmod-wl.x86_64
    echo 'Done.'
    drivers
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && drivers;;
esac
}


# CONFIGURE SYSTEM
function config {
echo ''
echo '1. Set preferred application-specific settings?'
echo '2. Show all startup applications?'
echo '3. Enable middle button scrolling on Thinkpads.'
echo '4. Change SELinux perm.'
echo 'r. Return'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
# GSettings
1)  
    # Font settings
    echo 'Setting font preferences...'
    gsettings set org.gnome.desktop.interface text-scaling-factor '1.0'
    gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 10'
    gsettings set org.gnome.desktop.interface font-name 'Cantarell 10'
    gsettings set org.gnome.nautilus.desktop font 'Cantarell 10'
    gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Cantarell Bold 10'
    gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'
    gsettings set org.gnome.settings-daemon.plugins.xsettings hinting 'full'
    echo 'Done. '
    # GNOME Shell Settings
    echo 'Setting GNOME Shell window button preferences...'
    gsettings set org.gnome.shell.overrides button-layout ':close'
    echo 'Done. '
    # Nautilus Preferences
    echo 'Setting Nautilus preferences...'
    gsettings set org.gnome.nautilus.preferences sort-directories-first true
    # Gedit Preferences
    echo 'Setting Gedit preferences...'
    gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
    gsettings set org.gnome.gedit.preferences.editor create-backup-copy false
    gsettings set org.gnome.gedit.preferences.editor auto-save true
    gsettings set org.gnome.gedit.preferences.editor insert-spaces true
    gsettings set org.gnome.gedit.preferences.editor tabs-size 4
    # Rhythmbox Preferences
    echo 'Setting Rhythmbox preferences...'
    gsettings set org.gnome.rhythmbox.rhythmdb monitor-library true
    gsettings set org.gnome.rhythmbox.sources browser-views 'artists-albums'
    # Tap-To-Click
    echo 'Enabling Tap-to-click...'
    gsettings set org.gnome.settings-daemon.peripherals.touchpad tap-to-click true
    # Done
    echo "Done."
    config
    ;;
# Startup Applications
2)
    echo 'Changing display of startup applications.'
    echo 'Requires root privileges:'    
    cd /etc/xdg/autostart/ && sudo sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop
    cd
    echo 'Done.'
    config
    ;;    
# Enable Thinkpad Scrolling
3)
    # Create .conf file
    echo 'Creating configuration file...'
    touch 20-thinkpad-trackpoint.conf
    echo "Section "InputClass"
Identifier  "Trackpoint Wheel Emulation"
MatchProduct    "TPPS/2 IBM TrackPoint|DualPoint Stick|Synaptics Inc. Composite TouchPad / TrackPoint|ThinkPad USB Keyboard with TrackPoint|USB Trackpoint pointing device|Composite TouchPad / TrackPoint"
MatchDevicePath "/dev/input/event*"
Option      "EmulateWheel"      "true"
Option      "EmulateWheelButton"    "2"
Option      "Emulate3Buttons"   "false"
Option      "XAxisMapping"      "6 7"
Option      "YAxisMapping"      "4 5"
EndSection" >> 20-thinkpad-trackpoint.conf
    echo 'Done.'
    # Install
    echo 'Installing configuration...'
    echo 'Requires root privileges:'  
    sudo mv -r 20-thinkpad-trackpoint.conf /etc/X11/xorg.conf.d/
    echo 'Done.'
    config
    ;;
# SELinux
4)
    echo 'Setting SELinux to permissive mode...'
    echo 'Requires root privileges:'  
    sudo sed --in-place 's/SELINUX=.*$/SELINUX=permissive/g' /etc/selinux/config
    echo 'Done.'
    config
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && config;;
esac
}

# CLEANUP SYSTEM
function cleanup {
echo ''
echo '1. Remove unused pre-installed packages?'
echo '2. Remove old kernel(s)?'
echo '3. Remove duplicate packages?'
echo '4. Clean package cache?'
echo 'r. Return?'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
# Remove Unused Pre-installed Packages
1)
    echo 'Removing selected pre-installed applications...'
    echo 'Requires root privileges:'
    sudo yum remove
    echo 'Done.'
    cleanup
    ;;
# Remove Old Kernel
2)
    echo 'Removing old Kernel(s)...'
    echo 'Requires root privileges:'
    sudo package-cleanup -y --oldkernels --count=1
    echo 'Done.'
    cleanup
    ;;
# Remove Duplicate Packages
3)
    echo 'Removing duplicate packages...'
    echo 'Requires root privileges:'
    sudo package-cleanup -y --cleandupes
    echo 'Done.'
    cleanup
    ;;
# Clean Package Cache
4)
    echo 'Cleaning package cache...'
    echo 'Requires root privileges:'
    sudo yum clean packages
    sudo yum clean headers
    echo 'Done.'
    cleanup
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && cleanup;;
esac
}

# Quit
function quit {
read -p "Are you sure you want to quit? (Y)es, (N)o " REPLY
case $REPLY in
    [Yy]* ) exit 99;;
    [Nn]* ) clear && main;;
    * ) clear && echo 'Sorry, try again.' && quit;;
esac
}

#----- MAIN FUNCTION -----#
function main {
echo ''
echo '1. Perform system update & upgrade?'
echo '2. Install favourite applications?'
echo '3. Install favourite system utilities?'
echo '4. Install development tools?'
echo '5. Install design tools?'
echo '6. Install third-party applications?'
echo '7. Install third-party drivers?'
echo '8. Configure third-party repositories?'
echo '9. Configure system?'
echo '10. Cleanup the system?'
echo 'q. Quit?'
echo ''
read -p 'What would you like to do? (Enter the your choice) : ' REPLY
case $REPLY in
    1) sysupgrade;; # System Upgrade
    2) clear && favourites;; # Install Favourite Applications
    3) clear && system;; # Install Favourite Tools
    4) clear && development;; # Install Dev Tools
    5) clear && design;; # Install Design Tools
    6) clear && thirdparty;; # Install Third-Party Applications
    7) clear && drivers;; # Install Third-Party Drivers
    8) clear && repos;; # Configure Third-Party Repositories
    9) clear && config;; # Configure system
    10) clear && cleanup;; # Cleanup System
    [Qq]* ) echo '' && quit;; # Quit
    * ) clear && echo 'Not an option, try again.' && main;;
esac
}

#----- RUN MAIN FUNCTION -----#
main

#END OF SCRIPT
