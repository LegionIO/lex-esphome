# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Update do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) { { id: 'update/firmware', state: 'UP-TO-DATE' }.to_json }

  before do
    stub_request(:get, 'http://10.0.0.1/update/firmware')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, 'http://10.0.0.1/update/firmware/install')
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#update_state' do
    it 'fetches update state via GET' do
      result = client.update_state(device: :lab, entity: 'firmware')
      expect(result).to include('state' => 'UP-TO-DATE')
    end
  end

  describe '#update_install' do
    it 'sends POST to install' do
      client.update_install(device: :lab, entity: 'firmware')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/update/firmware/install')
    end
  end
end
