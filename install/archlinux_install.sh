# This is not a file that should be executed. Rather it is a collection of
# notes on setting up Archlinux. Setting up a new computer with Arch I have
# found continuously frustrating, since I can't just clone my settings from
# github. This document will hopefully speed up future installs.


# =============================================================================
#
# The First Horror -- connecting to the internet
#
# =============================================================================

# Follow https://wiki.archlinux.org/index.php/Wireless_network_configuration step-by-step

ip link set wlp3s0 up
wpa_passphrase "NETGEAR08" "happyviolet021" > /etc/wpa_supplicant.conf
wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlp3s0

# Checkpoint -----------------------------------------------------------------
ip dev wlp3s0 scan # 1) this should get a long list of SSIDs
iw dev wlp3s0 link # 2) should show the SSID
# -----------------------------------------------------------------------------


# get an IP
dhclient wlp3s0  # should be fast if everything is good
                 # if things are not good, it will silentlly run out of time

# Checkpoint -----------------------------------------------------------------
# the daemon dhcpcd.service should be active and running
systemctl --type=service
# if it isn't do this:
systemctl restart dhcpcd.service
# -----------------------------------------------------------------------------

dhcpcd wlp3s0

# Checkpoint -----------------------------------------------------------------
ping 8.8.8.8 # should start pinging
# -----------------------------------------------------------------------------




# This doesn't usually make any problems
timedatectl set-ntp true



# =============================================================================
#
# The Second Horror -- partitioning
#
# =============================================================================

# Check you partitions:
lsblk

# * GOTO https://wiki.archlinux.org/index.php/Partitioning#GUID_Partition_Table
# * Use GPT
# * GPT is part of the EUFI specification, it uses GUIDs (aka UUIDs) to define
#   partitions, rather than labels. GPT replaces MBR.
# * UEFI is a replacement for BIOS
# * ESP aka EFI System Partitiona aka EFISYS -- the homolog of the boot
#   partition used in GPT-GRUB-BIOS setups
# * ESP holds UEFI bootloaders and other stuff, it is required for UEFI to boot
# * ESP should be 512M, FAT32 formatted
# * For Grub to boot from a GPT-partitioned disk, a BIOS boot partition is required

# OK, change of heart, configuring UEFI is really tedious. I stick with BIOS
# and GRUB for now.


# Format the ESP
mkfs.fat -F32 /dev/sdxY
