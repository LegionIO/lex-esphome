# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Sensor do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:response_body) { { 'id' => 'sensor/temperature', 'state' => '22.5 °C', 'value' => 22.5 } }

  before do
    stub_request(:get, 'http://10.0.0.1/sensor/temperature')
      .to_return(status: 200, body: response_body.to_json, headers: { 'Content-Type' => 'application/json' })
    stub_request(:get, 'http://10.0.0.1/sensor/temperature?detail=all')
      .to_return(status: 200, body: response_body.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  describe '#sensor_state' do
    it 'fetches sensor state via GET' do
      result = client.sensor_state(device: :lab, entity: 'temperature')
      expect(result).to include('id' => 'sensor/temperature')
    end

    it 'passes detail parameter when provided' do
      client.sensor_state(device: :lab, entity: 'temperature', detail: 'all')
      expect(WebMock).to have_requested(:get, 'http://10.0.0.1/sensor/temperature?detail=all')
    end

    it 'returns numeric value' do
      result = client.sensor_state(device: :lab, entity: 'temperature')
      expect(result['value']).to eq(22.5)
    end
  end
end
