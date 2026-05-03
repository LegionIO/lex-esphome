# lex-esphome: ESPHome Device Integration for LegionIO

**Repository Level 3 Documentation**
- **Parent**: `extensions-other/CLAUDE.md`
- **Grandparent**: `CLAUDE.md`

## Purpose

Legion Extension that connects LegionIO to ESPHome devices via the Web Server REST API. Provides runners for all 16 ESPHome entity domains, SSE event streaming for real-time state updates, periodic polling, and optional mDNS device discovery.

**GitHub**: https://github.com/LegionIO/lex-esphome
**License**: MIT
**Version**: 0.1.0

## Architecture

```
Legion::Extensions::Esphome
├── Runners/
│   ├── Sensor              # GET sensor state
│   ├── BinarySensor        # GET binary sensor state
│   ├── Switch              # GET/POST turn_on/turn_off/toggle
│   ├── Light               # GET/POST with brightness/color/effect params
│   ├── Fan                 # GET/POST with speed_level/oscillation
│   ├── Cover               # GET/POST open/close/stop/set position/tilt
│   ├── Select              # GET/POST set option
│   ├── Button              # POST press
│   ├── Number              # GET/POST set value
│   ├── Climate             # GET/POST mode/target_temp/fan_mode
│   ├── Lock                # GET/POST lock/unlock/open
│   ├── Text                # GET/POST set value
│   ├── MediaPlayer         # GET/POST play/pause/stop/set volume
│   ├── AlarmControlPanel   # GET/POST arm_away/arm_home/disarm (code via body)
│   ├── Update              # GET/POST install
│   ├── Valve               # GET/POST open/close/toggle/set position
│   └── Device              # GET / info, mDNS discovery
├── Helpers/
│   └── Client              # Faraday connection builder, device resolution from settings
├── Client                  # Standalone client class; includes all runners
└── Actors/
    ├── Events              # SSE /events stream listener per device
    ├── Poll                # Periodic state poll fallback
    └── Discovery           # mDNS device discovery (optional, disabled by default)
```

## Key Files

| Path | Purpose |
|------|---------|
| `lib/legion/extensions/esphome.rb` | Entry point, extension registration, `default_settings` |
| `lib/legion/extensions/esphome/helpers/client.rb` | Faraday connection builder + device resolution |
| `lib/legion/extensions/esphome/client.rb` | Standalone Client class for use outside framework |
| `lib/legion/extensions/esphome/runners/*.rb` | 17 runner modules (one per entity domain + device) |
| `lib/legion/extensions/esphome/actors/events.rb` | SSE stream listener with auto-reconnect |
| `lib/legion/extensions/esphome/actors/poll.rb` | Polling actor for periodic state fetch |
| `lib/legion/extensions/esphome/actors/discovery.rb` | mDNS discovery actor (requires `dnssd` gem) |

## Runner Methods

All runner methods accept `device:` and `entity:` keyword args. `device:` resolves from the config device registry.

## Configuration

```json
{
  "extensions": {
    "esphome": {
      "enabled": true,
      "devices": {
        "living_room": { "host": "192.168.1.50", "port": 80 },
        "garage": { "host": "esp-garage.local" }
      },
      "options": { "open_timeout": 5, "read_timeout": 10, "timeout": 10 },
      "events": { "enabled": true },
      "discovery": { "enabled": false, "interval": 300 }
    }
  }
}
```

## Dependencies

| Gem | Required | Purpose |
|-----|----------|---------|
| `faraday` (>= 2.0) | yes | HTTP client for REST API |
| `dnssd` | no | mDNS device discovery |

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

---

**Maintained By**: Matthew Iverson (@Esity)
