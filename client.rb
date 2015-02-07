$:.unshift('./gen-rb')

require 'thrift'
require 'dummy_service'

begin
  transport = Thrift::BufferedTransport.new(Thrift::Socket.new('127.0.0.1', 9191))
  protocol = Thrift::BinaryProtocol.new(transport)
  client = DummyService::Client.new(protocol)
  transport.open

  10000.times { |i| puts client.compute_value(i) }

rescue Thrift::Exception => ex
  puts "Thrift exception: #{ex.message}"
ensure
  transport.close
end
