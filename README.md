# Welding Helmet

![](img/noun_24911.png)

Ruby client(s) to view Spark.io event streams

## Getting started

- `bundle install`
- `cp dotenv.sample .env`
- replace dummy values in `.env` with your actual creds.
- `ruby simple.rb`
- press a button or otherwise actuate an event on your Spark microcontroller that sends an event to Spark.io with something like `Spark.publish("button_status","closed");`. See [internet_button](https://github.com/chaserx/internet_button) for an example.

The output of the above would be something like below:

`{"name":"button_status","data":"closed","ttl":"60","published_at":"2015-01-29T02:42:48.154Z","coreid":"54ababababa45"}`

Other outputs:

- Pushover

Add PUSHOVER_TOKEN and PUSHOVER_USER_KEY to your `.env` file and:

`ruby pushover.rb`

- Slack

Add the following parameters with their corresponding values to your `.env` file:
SLACK_WEBHOOL_URL, SLACK_CHANNEL_ID, SLACK_USERNAME, SLACK_ICON_EMOJI

`ruby slack.rb`

## Contribution

Pull requests welcome! Please see the [contribution guide](CONTRIBUTING.md).

## Attribution

MP3 from [millidavids](https://github.com/millidavids/hooker-button-extension)

Welder image courtesy of [Luis Prado via the Noun Project](http://thenounproject.com/term/welder/24911/)
