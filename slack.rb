# want to post to a Slack channel

#!/bin/sh
curl -X POST https://slack.com/api/chat.postMessage \
     --data-urlencode "text=$@" \
     -d token=$SLACK_TOKEN \
     -d channel=$SLACK_CHANNEL_ID \
     -d username=$SLACK_USERNAME \
     -d icon_url=$SLACK_ICON_URL \
     -d pretty=1

require 'bundler/setup'
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
    slack_url = 'https://slack.com/api/chat.postMessage'
    body = { token: ENV['SLACK_TOKEN'], channel: ENV['SLACK_CHANNEL_ID'],
             username: ENV['SLACK_USERNAME'], icon_url: ENV['SLACK_ICON_URL'],
             pretty: 1 }
    http = EventMachine::HttpRequest.new(slack_url).post body: body

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
