#!/usr/bin/env ruby -w
# rm_kernels.rb
# Author: Andy Bettisworth
# Description: Remove old and unused linux kernels

require 'fileutils'

$LOAD_PATH.push File.expand_path('../../', __FILE__)

require 'admin/admin'

module Admin
  current_kernel = `uname -r`.chomp
  lib_modules    = Dir['/lib/modules/**']
  boot_files     = Dir['/boot/**'].select! { |x| File.file?(x) }

  lib_modules.each do |kernel|
    target_kernel = File.basename(kernel).chomp
    unless current_kernel == target_kernel
      puts "removing #{kernel}..."
      `sudo rm -rf #{kernel}`
    end
  end

  boot_files.each do |f|
    target_file = File.basename(f).chomp
    unless target_file.match(/#{current_kernel}/)
      puts "removing #{f}..."
      `sudo rm -rf #{f}`
    end
  end
end
