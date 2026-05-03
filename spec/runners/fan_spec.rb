# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Fan do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) { { id: 'fan/ceiling', state: 'ON', speed_level: 3 }.to_json }

  before do
    stub_request(:get, 'http://10.0.0.1/fan/ceiling')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/fan/ceiling/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#fan_state' do
    it 'fetches fan state via GET' do
      result = client.fan_state(device: :lab, entity: 'ceiling')
      expect(result).to include('speed_level' => 3)
    end
  end

  describe '#fan_turn_on' do
    it 'sends POST to turn_on' do
      client.fan_turn_on(device: :lab, entity: 'ceiling')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/fan/ceiling/turn_on')
    end

    it 'passes speed_level param' do
      client.fan_turn_on(device: :lab, entity: 'ceiling', speed_level: 5)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/fan/ceiling/turn_on')
        .with(query: hash_including('speed_level' => '5'))
    end
  end

  describe '#fan_turn_off' do
    it 'sends POST to turn_off' do
      client.fan_turn_off(device: :lab, entity: 'ceiling')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/fan/ceiling/turn_off')
    end
  end

  describe '#fan_toggle' do
    it 'sends POST to toggle' do
      client.fan_toggle(device: :lab, entity: 'ceiling')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/fan/ceiling/toggle')
    end
  end
end
