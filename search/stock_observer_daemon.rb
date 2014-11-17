#!/usr/bin/ruby -w
# stock_observer_daemon.rb
# Author: Andy Bettisworth
# Description: Observe stocks as a Daemon

class StockServerObserver < Daemon
  def initialize(opts = {})
    super()
    @opts = opts
  end

  def service_init
    @interval = @opts[:interval] || 60
    @logger = Logger.new(@opts[:logfile] || 'c:/observer.log')
    @stock = SOAP::RPC::Driver.new(
      @opts[:soap_url] || 'http://localhost:2000',
      @opts[:soap_urn] || 'urn:Stock'
    )
    @stock.add_method('get_report')
    @sm = StatusMonitorClient.new(
      @opts[:sm_host] || '127.0.0.1',
      @opts[:sm_port] || 'urn:Stock'
    )
    @logger.info('Observer has been initialized.')
  end

  def test_stock_service
    @stock.get_report.class == Hash
  end

  def service_main
    @logger.info('Observer has been started.')
    sleep 1 while state != RUNNING
    while state == RUNNING
      if !test_stock_service
        msg = 'Stock service is not running.'
        @logger.warn(msg)
        @sm.warn('stock', msg)
      else
        @logger.info('Stock service is running.')
      end
      sleep(@interval)
    end
    @logger.info('Observer has been stoppend.')
  end
end

if __FILE__ == $0
  observer = StockServerObserver.new
end
