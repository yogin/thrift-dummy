$:.unshift('./gen-rb')

require 'thrift'
require 'dummy_service'

class DummyServiceHandler
  def compute_value(base)
    puts "base=#{base}"
    base * 42
  end
end

processor = DummyService::Processor.new(DummyServiceHandler.new)
transport = Thrift::ServerSocket.new(9191)
transportFactory = Thrift::BufferedTransportFactory.new
server = Thrift::SimpleServer.new(processor, transport, transportFactory)

puts "it begins..."
server.serve
puts "all done!"

