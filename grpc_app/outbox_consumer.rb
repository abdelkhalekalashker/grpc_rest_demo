# outbox_consumer.rb
require 'json'
require 'net/http'
require 'uri'

OUTBOX_FILE = "outbox.log"
TEMP_FILE   = "outbox_tmp.log"

def send_to_rest_api(result)
  uri = URI("http://localhost:4567/log_result")
  http = Net::HTTP.new(uri.host, uri.port)
  req = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
  req.body = { result: result }.to_json
  res = http.request(req)
  res.code == "200"
rescue => e
  puts "Failed to deliver: #{e.message}"
  false
end

File.open(TEMP_FILE, "w") do |temp|
  File.foreach(OUTBOX_FILE) do |line|
    record = JSON.parse(line)
    if record["delivered"]
      temp.puts(line)
    else
      if send_to_rest_api(record["result"])
        record["delivered"] = true
        temp.puts(record.to_json)
        puts "Delivered: #{record["result"]}"
      else
        temp.puts(line) # still pending
      end
    end
  end
end

File.rename(TEMP_FILE, OUTBOX_FILE)
