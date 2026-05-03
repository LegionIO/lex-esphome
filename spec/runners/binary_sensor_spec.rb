# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::BinarySensor do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }

  before do
    stub_request(:get, 'http://10.0.0.1/binary_sensor/motion')
      .to_return(status: 200, body: { id: 'binary_sensor/motion', state: 'ON', value: true }.to_json,
                 headers: { 'Content-Type' => 'application/json' })
  end

  describe '#binary_sensor_state' do
    it 'fetches binary sensor state via GET' do
      result = client.binary_sensor_state(device: :lab, entity: 'motion')
      expect(result).to include('state' => 'ON')
    end

    it 'returns boolean value' do
      result = client.binary_sensor_state(device: :lab, entity: 'motion')
      expect(result['value']).to be true
    end
  end
end
