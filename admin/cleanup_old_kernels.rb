#!/usr/bin/env ruby -w
# cleanup_old_kernels.rb
# Author: Andy Bettisworth
# Description: Remove old and unused linux kernels

require 'fileutils'

current_kernel = `uname -r`.chomp
lib_modules    = Dir['/lib/modules/**']
boot_files     = Dir['/boot/**'].select! { |x| File.file?(x) }

lib_modules.each do |kernel|
  target_kernel = File.basename(kernel).chomp
  unless current_kernel == target_kernel
    puts kernel
    # FileUtils.rm_rf(kernel)
  end
end

# boot_files.each do |f|
#   target_file = File.basename(f).chomp
#   unless target_file.match(/#{current_kernel}/)
#     FileUtils.rm_rf(f)
#   end
# end
