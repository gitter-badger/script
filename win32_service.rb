#!/usr/bin/ruby -w
# win32_service.rb
# Author: Andy Bettisworthu
# Description: Create a Win32 Service

require 'win32/service'

include win32

def install_service(name, display_name, executable)
  service = Service.new
  service.create_service do |s|
    s.service_name = name
    s.dispaly_name = display_name
    s.binary_path_name = 'ruby ' + File.expand_path(executable)
    s.dependencies = []
  end

  service.close
  puts "#{name} has been installed."
end

# irb> service_name = 'StockObserver'
# irb> install_service()
# irb>    service_name,
# irb>    'PragBouquet Observer',
# irb>    'stock_observer.rb',
# irb>    )

def start_service(name)
  Service.start(name)
  started = false
  while !started
    s = Service.status(name)
    started = (s.current_state == 'running')
    break if started
    puts 'Trying to start service..'
    sleep 1
  end
  puts "#{name} was started."
end

# irb> start_service(service_name)

def stop_service(name)
  Service.stop(name)
  stopped = false
  while !stopped
    s = Service.status(name)
    stopped = (s.current_state == 'stopped')
    break if stopped
    puts 'Trying to stop service.'
    sleep 1
  end
  puts "#{name} was stopped."
end

def uninstall_service(name)
  begin
    Service.stop(name)
  rescue
  end
  Service.delete(name)
  puts "#{name} was uninstalled."
end
