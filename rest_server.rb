# rest_server.rb
require 'sinatra'
require 'json'

post '/log_result' do
  request.body.rewind
  payload = JSON.parse(request.body.read)

  result = payload["result"]
  halt 400, "Missing result" unless result

  File.open("results.log", "a") do |file|
    file.puts "Result: #{result} at #{Time.now}"
  end

  status 200
  { message: "Result logged successfully" }.to_json
end
