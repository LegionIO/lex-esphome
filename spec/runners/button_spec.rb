# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Button do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }

  before do
    stub_request(:post, 'http://10.0.0.1/button/restart/press')
      .to_return(status: 200, body: '{}', headers: json_headers)
  end

  describe '#button_press' do
    it 'sends POST to press' do
      client.button_press(device: :lab, entity: 'restart')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/button/restart/press')
    end
  end
end
