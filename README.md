# Legion::Extensions::Esphome

A Legion Extension to process messages coming from the [ESPHome](https://esphome.io/) Project
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lex-esphome'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install lex-esphome

## Adding to Legion
You can manually install with a `gem install lex-esphome` command or by adding it into your settings with something like this
```json
{
  "extensions": {
    "esphome": {
      "enabled": true, "workers": 1
    }
  }
}
```

Example [shoveler](https://www.rabbitmq.com/shovel.html) definition to get data over from `/` to `/legion` when using [RabbitMQ + MQTT](https://www.rabbitmq.com/mqtt.html)
```json
{
  "permissions": [{
    "user": "legion",
	"vhost": "/",
	"read": "to_legion"
  }],
  "parameters": [{
	"value": {
	  "dest-exchange": "esphome",
	  "dest-protocol": "amqp091",
	  "dest-uri": "amqp://legion@/legion",
	  "src-delete-after": "never",
	  "src-protocol": "amqp091",
	  "src-queue": "to_legion",
	  "src-uri": "amqp://"
	},
	"vhost": "legion",
	"component": "shovel",
	"name": "ESPHome -> Legion"
  }],
	"queues": [{
      "name": "to_legion",
	  "vhost": "/",
	  "durable": true,
	}],
	"bindings": [{
	  "source": "amq.topic",
	  "vhost": "/",
	  "destination": "to_legion",
	  "destination_type": "queue",
	  "routing_key": "#.sensor.#.state",
	  "arguments": {}
	}, {
	  "source": "amq.topic",
	  "vhost": "/",
	  "destination": "to_legion",
	  "destination_type": "queue",
	  "routing_key": "esphome.logs.#",
	  "arguments": {}
	}]
}
```

## Usage
There are two passive runners within this Lex. One to process log entries, the other to process sensor data

|runner|function|value|routing key|timestamp_in_ms|
|---|---|---|---|---|
|Logs|process|required|required|X|
|Sensors|process|required|required|optional|


## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
