# lex-esphome

LegionIO extension for ESPHome device control via the [Web Server REST API](https://esphome.io/web-api/).

## Supported Entity Domains

sensor, binary_sensor, switch, light, fan, cover, select, button, number, climate, lock, text, media_player, alarm_control_panel, update, valve

## Installation

Add to your Gemfile:

```ruby
gem 'lex-esphome'
```

## Configuration

```json
{
  "extensions": {
    "esphome": {
      "enabled": true,
      "devices": {
        "living_room": { "host": "192.168.1.50", "port": 80 }
      }
    }
  }
}
```

## Standalone Usage

```ruby
require 'legion/extensions/esphome/client'

client = Legion::Extensions::Esphome::Client.new(
  devices: { office: { host: '192.168.1.51' } }
)

client.get_state(device: :office, entity: 'temperature')
client.turn_on(device: :office, entity: 'desk_lamp', brightness: 200)
client.toggle(device: :office, entity: 'fan')
```

## License

MIT
