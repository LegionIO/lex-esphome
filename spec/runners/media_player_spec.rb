# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::MediaPlayer do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) { { id: 'media_player/speaker', state: 'PLAYING', volume: 0.5 }.to_json }

  before do
    stub_request(:get, 'http://10.0.0.1/media_player/speaker')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/media_player/speaker/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#media_player_state' do
    it 'fetches media player state via GET' do
      result = client.media_player_state(device: :lab, entity: 'speaker')
      expect(result).to include('state' => 'PLAYING')
    end
  end

  describe '#media_player_play' do
    it 'sends POST to play' do
      client.media_player_play(device: :lab, entity: 'speaker')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/media_player/speaker/play')
    end
  end

  describe '#media_player_pause' do
    it 'sends POST to pause' do
      client.media_player_pause(device: :lab, entity: 'speaker')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/media_player/speaker/pause')
    end
  end

  describe '#media_player_stop' do
    it 'sends POST to stop' do
      client.media_player_stop(device: :lab, entity: 'speaker')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/media_player/speaker/stop')
    end
  end

  describe '#media_player_set_volume' do
    it 'sends POST with volume param' do
      client.media_player_set_volume(device: :lab, entity: 'speaker', volume: 0.8)
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/media_player/speaker/set')
        .with(query: { 'volume' => '0.8' })
    end
  end
end
