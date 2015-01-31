require 'bundler/setup'
Bundler.require
require 'eventmachine'
require 'em-eventsource'
require 'dotenv'

Dotenv.load

base_url = 'https://api.spark.io'
device_event_path = "/v1/devices/#{ENV['DEVICE_ID']}/events/#{ENV['EVENT_NAME']}"

puts "listening at: #{base_url+device_event_path}"

EM.run do
  # GET /v1/devices/:device_id/events/[:event_name]
  url = URI.join(base_url, device_event_path)
  puts url
  query = {}
  headers = {'Authorization' => "Bearer #{ENV['ACCESS_TOKEN']}"}
  source = EventMachine::EventSource.new(url, query, headers)

  source.message do |message|
    puts message
  end

  source.on ENV['EVENT_NAME'] do |message|
    puts message
  end

  source.error do |error|
    puts "error #{error}"
  end

  source.start # Start listening
end
