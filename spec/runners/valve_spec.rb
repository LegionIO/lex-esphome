# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Valve do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) { { id: 'valve/irrigation', state: 'CLOSED', value: 0.0 }.to_json }

  before do
    stub_request(:get, 'http://10.0.0.1/valve/irrigation')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/valve/irrigation/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#valve_state' do
    it 'fetches valve state via GET' do
      result = client.valve_state(device: :lab, entity: 'irrigation')
      expect(result).to include('state' => 'CLOSED')
    end
  end

  describe '#valve_open' do
    it 'sends POST to open' do
      client.valve_open(device: :lab, entity: 'irrigation')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/valve/irrigation/open')
    end
  end

  describe '#valve_close' do
    it 'sends POST to close' do
      client.valve_close(device: :lab, entity: 'irrigation')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/valve/irrigation/close')
    end
  end

  describe '#valve_toggle' do
    it 'sends POST to toggle' do
      client.valve_toggle(device: :lab, entity: 'irrigation')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/valve/irrigation/toggle')
    end
  end

  describe '#valve_set' do
    it 'sends POST with position param' do
      client.valve_set(device: :lab, entity: 'irrigation', position: 0.5)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/valve/irrigation/set')
        .with(query: { 'position' => '0.5' })
    end
  end
end
