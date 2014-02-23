#!/usr/bin/ruby -w
# annex_sync_spec.rb
# Author: Andy Bettisworth
# Description: Sync local and remote Annex

class AnnexSync
  LOCAL_SYNC = "#{ENV['HOME']}/.sync"
  REMOTE_SYNC = "/media/Annex/preseed/seed/.sync"

  def sync
    raise 'USB Annex not found.' unless File.exist?(REMOTE_SYNC)

    system <<-EOF
cd #{LOCAL_SYNC}/.canvas;
git pull usb_canvas master;

cd #{LOCAL_SYNC}/.script;
git pull usb_script master;

cd #{LOCAL_SYNC}/.template;
git pull usb_template master;
    EOF

    system <<-EOF
cd #{REMOTE_SYNC}/.canvas;
git pull local_canvas master;

cd #{REMOTE_SYNC}/.script;
git pull local_script master;

cd #{REMOTE_SYNC}/.template;
git pull local_template master;
    EOF
  end
end

arbiter = AnnexSync.new
arbiter.sync