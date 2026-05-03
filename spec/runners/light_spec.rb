# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::Light do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) do
    { id: 'light/desk_lamp', state: 'ON', brightness: 200, color: { r: 255, g: 255, b: 255 } }.to_json
  end

  before do
    stub_request(:get, 'http://10.0.0.1/light/desk_lamp')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/light/desk_lamp/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#light_state' do
    it 'fetches light state via GET' do
      result = client.light_state(device: :lab, entity: 'desk_lamp')
      expect(result).to include('state' => 'ON', 'brightness' => 200)
    end
  end

  describe '#light_turn_on' do
    it 'sends POST to turn_on' do
      client.light_turn_on(device: :lab, entity: 'desk_lamp')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/light/desk_lamp/turn_on')
    end

    it 'passes brightness as query param' do
      client.light_turn_on(device: :lab, entity: 'desk_lamp', brightness: 128)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/light/desk_lamp/turn_on')
        .with(query: hash_including('brightness' => '128'))
    end

    it 'passes color params' do
      client.light_turn_on(device: :lab, entity: 'desk_lamp', red: 255, green: 0, blue: 128)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/light/desk_lamp/turn_on')
        .with(query: hash_including('r' => '255', 'g' => '0', 'b' => '128'))
    end

    it 'passes effect param' do
      client.light_turn_on(device: :lab, entity: 'desk_lamp', effect: 'rainbow')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/light/desk_lamp/turn_on')
        .with(query: hash_including('effect' => 'rainbow'))
    end

    it 'omits nil params' do
      client.light_turn_on(device: :lab, entity: 'desk_lamp', brightness: 200)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/light/desk_lamp/turn_on')
        .with(query: { 'brightness' => '200' })
    end
  end

  describe '#light_turn_off' do
    it 'sends POST to turn_off' do
      client.light_turn_off(device: :lab, entity: 'desk_lamp')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/light/desk_lamp/turn_off')
    end

    it 'passes transition param' do
      client.light_turn_off(device: :lab, entity: 'desk_lamp', transition: 2)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/light/desk_lamp/turn_off')
        .with(query: hash_including('transition' => '2'))
    end
  end

  describe '#light_toggle' do
    it 'sends POST to toggle' do
      client.light_toggle(device: :lab, entity: 'desk_lamp')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/light/desk_lamp/toggle')
    end
  end
end
