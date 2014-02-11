#!/usr/local/env ruby -w
# package_kvm.rb
# Description: Canvas Kernel Virtual Machine package

######### QEMU && KVM #########
# # CHECK Virtualization supported
# # number returned is core count
#
# egrep -o '(vmx|svm)' /proc/cpuinfo;
# kvm-ok;
# uname -m;

# # BACKUP [/etc/default/qemu-kvm]
# sudo cp /etc/default/qemu-kvm $SEED/backup/qemu-kvm-$TODAY;

# # ADD user to libvrtd group

# # CREATE network interfaces
# ip route list;

# # CHECK KVM running
# sudo virsh -c qemu:///system list;

# # CONNECT to KVM server
# sudo virt-manager -c qemu:///system kvmhost;

# NOTE - Summary
# 1. Installing virt-manager, bridge-utils, qemu-kvm, and related packages.
# 2. Make sure each user wishing to use kvm are in the libvirtd group.
# 3. Defining /etc/network/interfaces as above (which match the quoted article).
# 4. Reboot, making sure Ethernet is plugged in and wireless (if any) is off.
# 5. Either run kvm against an image directly
# with, e.g. -device e1000,netdev=tunnel -netdev tap,id=tunnel,ifname=vnet0,
# or create a virtual machine with virt-manager,
# specifying network Bridge br0 under the Step 4->Advanced Options panel.

# NOTE - General
# 1. You can run 32- or 64-bit guests on a 64-bit system,
# but you can run only 32-bit guests on a 32-bit system.
# 2. To serve more than 2GB of RAM for your VMs,
# you must use a 64-bit kernel
# 3. x86_64 indicates a running 64-bit kernel.
# If you use see i386, i486, i586 or i686, you're running a 32-bit kernel.
# 4. Make sure it is enabled in your system BIOS.
# 5. Type 1 (or native, bare metal) hypervisors run directly on the host's hardware.
# Type 2 (or hosted) hypervisors run within a conventional operating-system environment.
# 6. Check Ethernet is plugged in and wireless (if any) is off.

# NOTE - The minimum system requirements by OS
# Ubuntu Server: 300 MHz processor, 128 MB RAM, and 1 GB hard drive space.
# Ubuntu Desktop: 700 MHz processor, 512 MiB RAM, and 5 GB of hard-drive space.

# NOTE - Files
# VM config [/etc/libvirt/qemu/*]
# Image files [/var/lib/libvirt/images/*.img]

# NOTE - Common Tasks
# 1. To list running virtual machines:
  # virsh -c qemu:///system list
# 2. To start a virtual machine:
  # virsh -c qemu:///system start web_devel
# 3. Similarly, to start a virtual machine at boot:
  # virsh -c qemu:///system autostart web_devel
# 4. Reboot a virtual machine with:
  # virsh -c qemu:///system reboot web_devel
# 5. The state of virtual machines can be saved to a file in order to be restored later.
# The following will save the virtual machine state into a file named according to the date:
# Once saved the virtual machine will no longer be running.
  # virsh -c qemu:///system save web_devel web_devel-022708.state
# 6. A saved virtual machine can be restored using:
  # virsh -c qemu:///system restore web_devel-022708.state
# 7. To shutdown a virtual machine do:
  # virsh -c qemu:///system shutdown web_devel
# 8. A CDROM device can be mounted in a virtual machine by entering:
  # virsh -c qemu:///system attach-disk web_devel /dev/cdrom /media/cdro

# NOTE - How-to expose guest services to networking
# 1. Prepare and configure any firewall service you will need.
# 2. Assign a static address in either
# your guest configuration or in your DHCP service.
# 3. If you are using a NAT router
# open a port for the service you are implementing directing it to the guest's IP address.

# NOTE - Tools
# virsh (1)            - management user interface
# virt-manager (1)     - display the virtual machine desktop management tool
# virt-viewer (1)      - display the graphical console for a virtual machine
# virt-clone (1)       - clone existing virtual machine images
# brctl (8)            - ethernet bridge administration
# ifconfig (8)         - configure a network interface
# dhclient (8)         - Dynamic Host Configuration Protocol Client

# NOTE - Errors
# 1. “could not initialize HAL for interface listing”.
# HAL of course has been deprecated and removed from Ubuntu
# (and replaced by Udev) so its not a surprise that it can’t be found.
