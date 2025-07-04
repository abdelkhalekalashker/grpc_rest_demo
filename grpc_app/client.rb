# client.rb
require 'grpc'
require_relative './lib/sum_services_pb'
require_relative './outbox_writer'

def main
  stub = Sum::Result::Stub.new('localhost:50051', :this_channel_is_insecure)
  puts "🔵 gRPC client running. Enter two integers to add them."
  puts "Enter first integer (a):"
  a = gets.chomp.to_i
  puts "Enter second integer (b):"
  b = gets.chomp.to_i
  request = Sum::SumRequest.new(a:, b:)
  response = stub.add(request)
  puts "✅ #{a} + #{b} = #{response.result}"
  OutboxWriter.write_result(response.result)
end

main
