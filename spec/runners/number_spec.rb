# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Number do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) { { id: 'number/brightness_threshold', state: '50', value: 50 }.to_json }

  before do
    stub_request(:get, 'http://10.0.0.1/number/brightness_threshold')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/number/brightness_threshold/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#number_state' do
    it 'fetches number state via GET' do
      result = client.number_state(device: :lab, entity: 'brightness_threshold')
      expect(result['value']).to eq(50)
    end
  end

  describe '#number_set' do
    it 'sends POST with value param' do
      client.number_set(device: :lab, entity: 'brightness_threshold', value: 75)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/number/brightness_threshold/set')
        .with(query: { 'value' => '75' })
    end
  end
end
