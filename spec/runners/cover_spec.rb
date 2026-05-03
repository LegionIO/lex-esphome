# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Cover do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) { { id: 'cover/garage', state: 'CLOSED', value: 0.0, current_operation: 'IDLE' }.to_json }

  before do
    stub_request(:get, 'http://10.0.0.1/cover/garage')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/cover/garage/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#cover_state' do
    it 'fetches cover state via GET' do
      result = client.cover_state(device: :lab, entity: 'garage')
      expect(result).to include('state' => 'CLOSED')
    end
  end

  describe '#cover_open' do
    it 'sends POST to open' do
      client.cover_open(device: :lab, entity: 'garage')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/cover/garage/open')
    end
  end

  describe '#cover_close' do
    it 'sends POST to close' do
      client.cover_close(device: :lab, entity: 'garage')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/cover/garage/close')
    end
  end

  describe '#cover_stop' do
    it 'sends POST to stop' do
      client.cover_stop(device: :lab, entity: 'garage')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/cover/garage/stop')
    end
  end

  describe '#cover_set' do
    it 'sends POST with position param' do
      client.cover_set(device: :lab, entity: 'garage', position: 0.5)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/cover/garage/set')
        .with(query: hash_including('position' => '0.5'))
    end

    it 'sends POST with tilt param' do
      client.cover_set(device: :lab, entity: 'garage', tilt: 0.3)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/cover/garage/set')
        .with(query: hash_including('tilt' => '0.3'))
    end
  end
end
