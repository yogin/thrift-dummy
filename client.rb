$:.unshift('./gen-rb')

require 'benchmark'
require 'thrift'
require 'dummy_service'

begin
  transport = Thrift::BufferedTransport.new(Thrift::Socket.new('127.0.0.1', 9191))
  protocol = Thrift::BinaryProtocol.new(transport)
  client = DummyService::Client.new(protocol)
  transport.open

  Benchmark.bm do |x|
    x.report { 50000.times { |i| client.compute_value(i) } }
  end

rescue Thrift::Exception => ex
  puts "Thrift exception: #{ex.message}"
ensure
  transport.close
end
