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

Similarly, you can send the same output to your phone via Pushover.

`ruby pushover.rb`

## Contribution

Pull requests welcome! Please see the [contribution guide](CONTRIBUTING.md).

## Attribution

Welder image courtesy of [Luis Prado via the Noun Project](http://thenounproject.com/term/welder/24911/)
