# server.rb
require 'grpc'
require_relative './lib/sum_services_pb'

# Define the service implementation
class SumService < Sum::Result::Service
  def add(request, _unused_call)
    result = request.a + request.b
    Sum::SumResponse.new(result: result)
  end
end

# Start the gRPC server
def main
  server = GRPC::RpcServer.new
  server.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  server.handle(SumService)
  puts "🟢 gRPC server running on port 50051"
  server.run_till_terminated
end

main if __FILE__ == $0
