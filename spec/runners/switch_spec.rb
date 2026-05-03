# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Switch do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:state_body) { { id: 'switch/relay', state: 'ON', value: true }.to_json }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }

  before do
    stub_request(:get, 'http://10.0.0.1/switch/relay')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, 'http://10.0.0.1/switch/relay/turn_on')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, 'http://10.0.0.1/switch/relay/turn_off')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, 'http://10.0.0.1/switch/relay/toggle')
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#switch_state' do
    it 'fetches switch state via GET' do
      result = client.switch_state(device: :lab, entity: 'relay')
      expect(result).to include('state' => 'ON')
    end
  end

  describe '#switch_turn_on' do
    it 'sends POST to turn_on' do
      client.switch_turn_on(device: :lab, entity: 'relay')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/switch/relay/turn_on')
    end
  end

  describe '#switch_turn_off' do
    it 'sends POST to turn_off' do
      client.switch_turn_off(device: :lab, entity: 'relay')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/switch/relay/turn_off')
    end
  end

  describe '#switch_toggle' do
    it 'sends POST to toggle' do
      client.switch_toggle(device: :lab, entity: 'relay')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/switch/relay/toggle')
    end
  end
end
