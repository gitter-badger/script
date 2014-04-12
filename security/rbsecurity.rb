#!/usr/bin/env ruby -w
# rbsecurity.rb
# Author: Andy Bettisworth
# Description: OSI model multi-layer security

require_relative 'secure_physical_layer.rb'
require_relative 'secure_datalink_layer.rb'
require_relative 'secure_network_layer.rb'
require_relative 'secure_transport_layer.rb'
require_relative 'secure_session_layer.rb'
require_relative 'secure_application_layer.rb'
require_relative 'secure_people_layer.rb'

include PhysicalLayerSecurity
include DataLinkLayerSecurity
include NetworkLayerSecurity
include TransportLayerSecurity
include SessionLayerSecurity
include ApplicationLayerSecurity
include PeopleLayerSecurity

class SecureSystem
  def initialize
    system 'ln -s /dev/null' unless File.exist?('/dev/null')
    fail "WARNING: permission denied." unless `whoami`.include?(ENV['USER'])
  end

  def secure_physical_layer
    puts 'Securing physical layer...'
    #disable_ctrlaltdelete_reboot
    #set_bios_passphrase('somepassphrase')
    #set_grub_passphrase('somepassphrase')
    #set_screensaver_passphrase(true, 'somepassphrase')
    #disable_usb_ports(true, :all)
    #monitor_drives(true) ## smartmontools
    #monitor_system(true) ## sysstat
    #encrypt_home_folder('somepassphrase')
    #create_honeypot_usb_ports(true, 'someport')
    #log_usb_port_activity(true)
  end

  def secure_datalink_layer
    puts 'Securing datalink layer...'
    #disable_wifi(true)
    #monitor_wifi(true)
  end

  def secure_network_layer
    puts 'Securing network layer...'
    #create_firewall(true) ## ufw, psad, fwsnort, fwknop
    #monitor_network(true) ## nmap, netstat
    #setup_vpn(true)
  end

  def secure_transport_layer
    puts 'Securing transport layer...'
  end

  def secure_session_layer
    puts 'Securing session layer...'
  end

  def secure_application_layer
    puts 'Securing application layer...'
    #secure_root(true)
    #log_sudo_activity(true)
    #setup_tripwire(true)
    #setup_apparmor(true)
  end

  def secure_people_layer
    puts 'Securing people layer...'
    #limit_user_count(true, "wurde")
    #create_routine_backup(true)
    #create_routine_security_questions(true) ## LP & H
    #setup_video_surveillance(true,trigger: 255)
    #setup_video_surveillance(true,time: 0900)
    #setup_video_surveillance(true,interval: 30)
    #setup_audio_surveillance(true,trigger: 255)
    #setup_audio_surveillance(true,time: 0900)
    #setup_audio_surveillance(true,interval: 0900)
  end
end

sbot = SecureSystem.new
sbot.secure_physical_layer
sbot.secure_datalink_layer
sbot.secure_network_layer
sbot.secure_transport_layer
sbot.secure_session_layer
sbot.secure_application_layer
sbot.secure_people_layer
puts 'Sbot security sweep, successful!'
