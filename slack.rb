# want to post to a Slack channel

require 'bundler/setup'
require 'json'

Bundler.require

Dotenv.load

base_url = 'https://api.spark.io'
device_event_path = "/v1/devices/#{ENV['DEVICE_ID']}/events/#{ENV['EVENT_NAME']}"
full_path = URI.join(base_url, device_event_path)
puts "listening at: #{full_path}"

EM.run do
  # GET /v1/devices/:device_id/events/:event_name
  url = full_path
  query = {}
  headers = {'Authorization' => "Bearer #{ENV['ACCESS_TOKEN']}"}
  source = EventMachine::EventSource.new(url, query, headers)

  source.message do |message|
    puts message
  end

  source.on ENV['EVENT_NAME'] do |message|
    slack_url = ENV['SLACK_WEBHOOL_URL']
    body = { token: ENV['SLACK_TOKEN'], channel: ENV['SLACK_CHANNEL_ID'],
             username: ENV['SLACK_USERNAME'], icon_emoji: ENV['SLACK_ICON_EMOJI'],
             text: 'i am internet button' }
    http = EventMachine::HttpRequest.new(slack_url).post body: body.to_json

    http.errback { p 'Uh oh'; EM.stop }
    http.callback {
      ap http.response_header.status
      ap http.response_header
      ap http.response
    }
  end

  source.error do |error|
    puts "error #{error}"
  end

  source.start # Start listening
end
