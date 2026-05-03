# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Climate do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) do
    { id: 'climate/thermostat', state: 'HEAT', current_temperature: 21.5, target_temperature: 23.0 }.to_json
  end

  before do
    stub_request(:get, 'http://10.0.0.1/climate/thermostat')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/climate/thermostat/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#climate_state' do
    it 'fetches climate state via GET' do
      result = client.climate_state(device: :lab, entity: 'thermostat')
      expect(result).to include('state' => 'HEAT')
    end
  end

  describe '#climate_set' do
    it 'sends POST with mode param' do
      client.climate_set(device: :lab, entity: 'thermostat', mode: 'COOL')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/climate/thermostat/set')
        .with(query: hash_including('mode' => 'COOL'))
    end

    it 'sends POST with target_temperature param' do
      client.climate_set(device: :lab, entity: 'thermostat', target_temperature: 24.0)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/climate/thermostat/set')
        .with(query: hash_including('target_temperature' => '24.0'))
    end

    it 'sends POST with fan_mode param' do
      client.climate_set(device: :lab, entity: 'thermostat', fan_mode: 'HIGH')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/climate/thermostat/set')
        .with(query: hash_including('fan_mode' => 'HIGH'))
    end

    it 'omits nil params' do
      client.climate_set(device: :lab, entity: 'thermostat', mode: 'AUTO')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/climate/thermostat/set')
        .with(query: { 'mode' => 'AUTO' })
    end
  end
end
