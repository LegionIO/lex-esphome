# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Client do
  subject(:client) do
    described_class.new(devices: { office: { host: '192.168.1.50', port: 80 } })
  end

  describe '#initialize' do
    it 'stores devices with symbolized keys' do
      expect(client.settings[:devices]).to have_key(:office)
    end

    it 'stores default timeout options' do
      expect(client.settings[:options]).to eq(open_timeout: 5, read_timeout: 10, timeout: 10)
    end

    it 'accepts custom timeouts' do
      c = described_class.new(devices: {}, open_timeout: 2)
      expect(c.settings[:options][:open_timeout]).to eq(2)
    end
  end

  describe '#resolve_device' do
    it 'resolves a known device' do
      expect(client.resolve_device(:office)).to eq(host: '192.168.1.50', port: 80)
    end

    it 'defaults port to 80' do
      c = described_class.new(devices: { test: { host: '10.0.0.1' } })
      expect(c.resolve_device(:test)[:port]).to eq(80)
    end

    it 'raises for unknown device' do
      expect { client.resolve_device(:unknown) }.to raise_error(ArgumentError, /unknown ESPHome device/)
    end
  end

  describe 'runner inclusion' do
    it { expect(client).to respond_to(:sensor_state) }
    it { expect(client).to respond_to(:binary_sensor_state) }
    it { expect(client).to respond_to(:switch_turn_on) }
    it { expect(client).to respond_to(:switch_turn_off) }
    it { expect(client).to respond_to(:switch_toggle) }
    it { expect(client).to respond_to(:light_turn_on) }
    it { expect(client).to respond_to(:light_turn_off) }
    it { expect(client).to respond_to(:fan_turn_on) }
    it { expect(client).to respond_to(:cover_open) }
    it { expect(client).to respond_to(:cover_close) }
    it { expect(client).to respond_to(:select_set) }
    it { expect(client).to respond_to(:button_press) }
    it { expect(client).to respond_to(:number_set) }
    it { expect(client).to respond_to(:climate_set) }
    it { expect(client).to respond_to(:lock_lock) }
    it { expect(client).to respond_to(:lock_unlock) }
    it { expect(client).to respond_to(:text_set) }
    it { expect(client).to respond_to(:media_player_play) }
    it { expect(client).to respond_to(:media_player_set_volume) }
    it { expect(client).to respond_to(:alarm_state) }
    it { expect(client).to respond_to(:alarm_arm_away) }
    it { expect(client).to respond_to(:alarm_disarm) }
    it { expect(client).to respond_to(:update_install) }
    it { expect(client).to respond_to(:valve_open) }
    it { expect(client).to respond_to(:device_info) }
    it { expect(client).to respond_to(:discover_mdns) }
  end
end
