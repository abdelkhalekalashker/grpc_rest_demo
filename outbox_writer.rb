# outbox_writer.rb
require 'json'
require 'securerandom'
require 'time'
class OutboxWriter
  OUTBOX_FILE = "outbox.log"

  def self.write_result(result)
    record = {
      id: SecureRandom.uuid,
      result: result,
      created_at: Time.now.utc.iso8601,
      delivered: false
    }
    File.open(OUTBOX_FILE, "a") { |f| f.puts(record.to_json) }
  end
end
