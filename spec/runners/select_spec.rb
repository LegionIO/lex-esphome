# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Select do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) { { id: 'select/mode', state: 'auto', value: 'auto' }.to_json }

  before do
    stub_request(:get, %r{http://10\.0\.0\.1/select/mode.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/select/mode/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#select_state' do
    it 'fetches select state via GET' do
      result = client.select_state(device: :lab, entity: 'mode')
      expect(result).to include('state' => 'auto')
    end
  end

  describe '#select_set' do
    it 'sends POST with option param' do
      client.select_set(device: :lab, entity: 'mode', option: 'manual')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/select/mode/set')
        .with(query: { 'option' => 'manual' })
    end
  end
end
