#!/usr/bin/ruby -w
# cleanup_old_kernels.rb
# Author: Andy Bettisworth
# Description: Remove old and unused linux kernels

current_kernel = `uname -r`.chomp
all_kernels = Dir['/lib/modules/**']

all_kernels.each do |kernel|
  target_kernel = File.basename(kernel).chomp

  unless current_kernel == target_kernel
    File.delete(kernel)
  end
end
