# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Device do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }

  before do
    stub_request(:get, 'http://10.0.0.1/')
      .to_return(status: 200, body: { name: 'lab-sensors', version: '2024.5.0' }.to_json, headers: json_headers)
  end

  describe '#device_info' do
    it 'fetches device info via GET /' do
      result = client.device_info(device: :lab)
      expect(result).to include('name' => 'lab-sensors')
    end

    it 'returns version' do
      result = client.device_info(device: :lab)
      expect(result).to include('version' => '2024.5.0')
    end
  end

  describe '#discover_mdns' do
    it 'raises LoadError when dnssd is not available' do
      allow(client).to receive(:require).with('dnssd').and_raise(LoadError)
      expect { client.discover_mdns }.to raise_error(LoadError, /dnssd gem is required/)
    end
  end
end
