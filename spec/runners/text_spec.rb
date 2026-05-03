# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Text do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) { { id: 'text/display_message', state: 'Hello', value: 'Hello' }.to_json }

  before do
    stub_request(:get, 'http://10.0.0.1/text/display_message')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/text/display_message/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#text_state' do
    it 'fetches text state via GET' do
      result = client.text_state(device: :lab, entity: 'display_message')
      expect(result).to include('value' => 'Hello')
    end
  end

  describe '#text_set' do
    it 'sends POST with value param' do
      client.text_set(device: :lab, entity: 'display_message', value: 'World')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/text/display_message/set')
        .with(query: { 'value' => 'World' })
    end
  end
end
