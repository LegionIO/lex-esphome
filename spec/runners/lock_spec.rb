# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Lock do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) { { id: 'lock/front_door', state: 'LOCKED', value: 'LOCKED' }.to_json }

  before do
    stub_request(:get, 'http://10.0.0.1/lock/front_door')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/lock/front_door/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#lock_state' do
    it 'fetches lock state via GET' do
      result = client.lock_state(device: :lab, entity: 'front_door')
      expect(result).to include('state' => 'LOCKED')
    end
  end

  describe '#lock_lock' do
    it 'sends POST to lock' do
      client.lock_lock(device: :lab, entity: 'front_door')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/lock/front_door/lock')
    end
  end

  describe '#lock_unlock' do
    it 'sends POST to unlock' do
      client.lock_unlock(device: :lab, entity: 'front_door')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/lock/front_door/unlock')
    end
  end

  describe '#lock_open' do
    it 'sends POST to open' do
      client.lock_open(device: :lab, entity: 'front_door')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/lock/front_door/open')
    end
  end
end
