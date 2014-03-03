#!/usr/bin/env ruby -w
# launchpad.rb
# Author: Andy Bettisworth
# Description: Shortcut to launch development environments

require 'fileutils'
require 'optparse'

class LaunchPad
  LAUNCHER_DIR = "/usr/share/applications"
  UNITY_LAUNCHER = "#{LAUNCHER_DIR}/launch_development_environment.desktop"
  TMP_LAUNCHER = "/tmp/launch_development_environment.desktop"

  def add
    set_target_project
    fail "Launchpad already exists for '#{@project_name}'." if launchpad_exist?
    add_launchpad
  end

  def remove
    set_target_project
    fail "Launchpad does not exist for '#{@project_name}'." unless launchpad_exist?
    remove_launchpad
  end

  def list
    # > TODO
  end

  private
  def set_target_project
    @project_name = File.basename(Dir.pwd).gsub(/[^[:alnum:]]/,'-')
    @checkout_branch = `cd #{Dir.pwd}; git rev-parse --abbrev-ref HEAD`.strip.gsub(/[^[:alnum:]]/,'-')
    fail "No git repository found. '#{@checkout_branch}'." unless valid_project?
  end

  def valid_project?
    @checkout_branch.empty? ? true : false
  end

  def launchpad_exist?
    system("cp #{UNITY_LAUNCHER} /tmp/")
    if File.read(TMP_LAUNCHER).include?("Action #{@project_name}")
      File.delete(TMP_LAUNCHER)
      return true
    end
    false
  end

  def add_launchpad
    transfer_file = String.new
    File.open(TMP_LAUNCHER, 'r').each_line do |line|
      if line.include?("Actions=")
        transfer_file << line.gsub("\n",'') + "#{@project_name}-#{@checkout_branch.strip};\n"
      else
        transfer_file << line
      end
    end
    transfer_file += <<-EOF

[Desktop Action #{@project_name}-#{@checkout_branch.strip}]
Name=#{@project_name}/#{@checkout_branch.strip}
Exec=ruby /home/wurde/.sync/.script/launcher/launch-#{@project_name}-#{@checkout_branch.strip}.rb
OnlyShowIn=Unity;
      EOF
    File.open(TMP_LAUNCHER, 'w+') { |f| f.write(transfer_file) }

    system <<-EOF
desktop-file-validate #{TMP_LAUNCHER};
sudo desktop-file-install --dir=#{LAUNCHER_DIR} --delete-original #{TMP_LAUNCHER};
    EOF

    # > CREATE launcher in /.script/launcher
  end

  def remove_launchpad
    transfer_file = String.new
    File.open(TMP_LAUNCHER, 'r').each_line do |line|
      if line.include?("Actions=")
        transfer_file << line.gsub("#{@project_name}-#{@checkout_branch.strip};",'')
      else
        transfer_file << line
      end
    end
    rm_action = <<-EOF

[Desktop Action #{@project_name}-#{@checkout_branch.strip}]
Name=#{@project_name}/#{@checkout_branch.strip}
Exec=ruby /home/wurde/.sync/.script/launcher/launch-#{@project_name}-#{@checkout_branch.strip}.rb
OnlyShowIn=Unity;
      EOF
    transfer_file.gsub!(rm_action,'')
    File.open(TMP_LAUNCHER, 'w+') { |f| f.write(transfer_file) }

    system <<-EOF
desktop-file-validate #{TMP_LAUNCHER};
sudo desktop-file-install --dir=#{LAUNCHER_DIR} --delete-original #{TMP_LAUNCHER};
    EOF

    # > DELETE launcher in /.script/launcher
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME, ".rb")
  opts.banner = "Usage: #{executable_name} [OPTION]..."

  opts.on('--add', 'Add a launchpad to project') do
    options[:add] = true
  end

  opts.on('--remove', 'Remove launchpad from project') do
    options[:remove] = true
  end
end.parse!

if options[:remove] == true
  Dir.chdir(Dir.pwd)
  launcher = LaunchPad.new
  launcher.remove
else
  Dir.chdir(Dir.pwd)
  launcher = LaunchPad.new
  launcher.add
end

# describe LaunchPad do
#   let(:test_project) { "#{ENV['HOME']}/Desktop/test_project" }
#   let(:unity_launcher) { "/usr/share/applications/launch_development_environment.desktop" }
#   let(:test_action) { "Actions=" }

#   def setup_test
#     unless File.directory?(test_project)
#       FileUtils.mkdir_p(test_project)
#     end
#   end

#   describe "#add" do
#     it "should create a Unity Launchbar 'Action'" do
#       setup_test
#       launcher = LaunchPad.new
#       Dir.chdir(test_project)
#       launcher.add
#       # expect(File.read(unity_launcher)).to include(test_action)
#     end

#     it "should create a launcher script"
#     it "should NOT duplicate action if project launcher exists"
#   end
# end