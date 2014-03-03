#!/usr/bin/ruby -w
# launchpad.rb
# Author: Andy Bettisworth
# Description: Shortcut to launch development environments

require 'fileutils'
require 'optparse'

class LaunchPad
  DESKTOP = "#{ENV['HOME']}/Desktop"
  APP_DIR = "#{ENV['HOME']}/.sync/.app"
  LAUNCHER_DIR = "/usr/share/applications"
  UNITY_LAUNCHER = "#{LAUNCHER_DIR}/launch_development_environment.desktop"
  SCRIPT_LAUNCHER = "#{ENV['HOME']}/.sync/.script/launcher"
  TMP_LAUNCHER = "/tmp/launch_development_environment.desktop"

  def add
    set_target_project
    fail "Launchpad already exists for '#{@project_name}'." if launchpad_exist?
    add_launchpad
    add_launch_script
  end

  def remove
    set_target_project
    fail "Launchpad does not exist for '#{@project_name}'." unless launchpad_exist?
    remove_launchpad
    remove_launch_script
  end

  def list
    system("cp #{UNITY_LAUNCHER} /tmp/")
    all_launchpads = Array.new
    File.open(TMP_LAUNCHER, 'r').each_line do |line|
      if line.include?("Actions=")
        all_launchpads << line.gsub("Actions=",'').strip.split(";")
      end
    end
    puts all_launchpads
  end

  private
  def set_target_project
    @project_name = File.basename(Dir.pwd).gsub(/[^[:alnum:]]/,'-')
    @checkout_branch = `cd #{Dir.pwd}; git rev-parse --abbrev-ref HEAD`.strip.gsub(/[^[:alnum:]]/,'-')
    fail "No git repository found. '#{@checkout_branch}'." unless valid_project?
  end

  def valid_project?
    return false if @checkout_branch.empty?
    true
  end

  def launchpad_exist?
    system("cp #{UNITY_LAUNCHER} /tmp/")
    if File.read(TMP_LAUNCHER).include?("Action #{@project_name}")
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
  end

  def add_launch_script
    File.open("#{SCRIPT_LAUNCHER}/launch-#{@project_name}-#{@checkout_branch.strip}.rb",'w+') do |file|
      init_script = <<-EOF
#!/usr/bin/env ruby -w
# launch-#{@project_name}-#{@checkout_branch.strip}.rb
# Author: Andy Bettisworth
# Description: Launch project #{@project_name}

require_relative 'rbwindow'

DESKTOP = "#{ENV['HOME']}/Desktop"
APP_DIR = "#{ENV['HOME']}/.sync/.app"

## Setup development environment
## Setup 2
window = RBWindow.new
window.close_all_windows
window.change_workspace("top-right")

## Clone project to Desktop
unless File.exist?("#{DESKTOP}/launch-#{@project_name}-#{@checkout_branch.strip}")
  system("git clone #{APP_DIR}/launch-#{@project_name}-#{@checkout_branch.strip} #{DESKTOP}/launch-#{@project_name}-#{@checkout_branch.strip};")
end

sleep(1)
## Sublime-Text-3
sublime_window = RBWindow.new
sublime_window.create_application("sublime", "#{DESKTOP}/launch-#{@project_name}-#{@checkout_branch.strip}")
sublime_window.relocate("top-right")
sublime_window.change_window_state('add','fullscreen')

## Gnome-Terminal
terminal_window = RBWindow.new
terminal_window.create_application("gnome-terminal","--working-directory=#{DESKTOP}/launch-#{@project_name}-#{@checkout_branch.strip}")
terminal_window.relocate("top-left");
terminal_window.change_window_state('add','fullscreen')

## Firefox
firefox_window = RBWindow.new
firefox_window.create_application("firefox", "127.0.0.1:3000")
firefox_window.relocate("bottom-right")
firefox_window.change_window_state('add','fullscreen')
      EOF
      file.write(init_script)
    end
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
  end

  def remove_launch_script
    if File.exist?("#{SCRIPT_LAUNCHER}/launch-#{@project_name}-#{@checkout_branch.strip}.rb")
      File.delete("#{SCRIPT_LAUNCHER}/launch-#{@project_name}-#{@checkout_branch.strip}.rb")
    end
  end
end

options = {}
OptionParser.new do |opts|
  executable_name = File.basename($PROGRAM_NAME, ".rb")
  opts.banner = "Usage: #{executable_name} [OPTION]..."

  opts.on('--add', 'Add a Unity Launcher for target git project') do
    options[:add] = true
  end

  opts.on('--remove', 'Remove Unity Launcher for target git project') do
    options[:remove] = true
  end
end.parse!

## USAGE
Dir.chdir(Dir.pwd)
launcher = LaunchPad.new
if options[:remove] == true
  launcher.remove
else
  launcher.add
end

## TEST
# describe LaunchPad do
#   let(:test_project) { "#{ENV['HOME']}/Desktop/test_project" }
#   let(:unity_launcher) { "/usr/share/applications/launch_development_environment.desktop" }
#   let(:script_launcher) { "#{ENV['HOME']}/.sync/.script/launcher" }
#   let(:test_action) { "test-project-master" }

#   def setup_test
#     unless File.exist?(test_project)
#       FileUtils.mkdir_p(test_project)
#       system <<-EOF
#         cd #{test_project};
#         git init;
#         git add .;
#         git commit -m "init";
#       EOF
#     end
#   end

#   describe "#add" do
#     it "should create a Unity Launchbar 'Action'", add: true do
#       setup_test
#       launcher = LaunchPad.new
#       Dir.chdir(test_project)
#       launcher.add
#       expect(File.open(unity_launcher,'r').readlines.to_s =~ /#{test_action}/).to_not be_nil
#     end

#     it "should create a launcher script", add_launcher: true do
#       setup_test
#       launcher = LaunchPad.new
#       Dir.chdir(test_project)
#       expect(Dir.entries(script_launcher)).to have_at_least(5).things
#     end
#   end

#   describe "#remove" do
#     it "should remove existing Unity Launcher 'Action'", remove: true do
#       setup_test
#       launcher = LaunchPad.new
#       Dir.chdir(test_project)
#       launcher.remove
#       expect(File.open(unity_launcher,'r').readlines.to_s =~ /#{test_action}/).to be_nil
#     end
#   end

#   describe "#list" do
#     it "should list all Unity Launcher 'Actions'", list: true do
#       setup_test
#       launcher = LaunchPad.new
#       Dir.chdir(test_project)
#       launcher.list
#     end
#   end
# end