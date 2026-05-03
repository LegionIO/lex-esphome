# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Legion::Extensions::Esphome::Runners::AlarmControlPanel do
  let(:client) { Legion::Extensions::Esphome::Client.new(devices: { lab: { host: '10.0.0.1' } }) }
  let(:json_headers) { { 'Content-Type' => 'application/json' } }
  let(:state_body) { { id: 'alarm_control_panel/home_alarm', state: 'DISARMED' }.to_json }

  before do
    stub_request(:get, 'http://10.0.0.1/alarm_control_panel/home_alarm')
      .to_return(status: 200, body: state_body, headers: json_headers)
    stub_request(:post, %r{http://10\.0\.0\.1/alarm_control_panel/home_alarm/.*})
      .to_return(status: 200, body: state_body, headers: json_headers)
  end

  describe '#alarm_state' do
    it 'fetches alarm state via GET' do
      result = client.alarm_state(device: :lab, entity: 'home_alarm')
      expect(result).to include('state' => 'DISARMED')
    end
  end

  describe '#alarm_arm_away' do
    it 'sends POST to arm_away' do
      client.alarm_arm_away(device: :lab, entity: 'home_alarm')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/alarm_control_panel/home_alarm/arm_away')
    end

    it 'sends code in POST body' do
      client.alarm_arm_away(device: :lab, entity: 'home_alarm', code: '1234')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/alarm_control_panel/home_alarm/arm_away')
        .with(body: 'code=1234')
    end
  end

  describe '#alarm_arm_home' do
    it 'sends POST to arm_home' do
      client.alarm_arm_home(device: :lab, entity: 'home_alarm')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/alarm_control_panel/home_alarm/arm_home')
    end
  end

  describe '#alarm_arm_night' do
    it 'sends POST to arm_night' do
      client.alarm_arm_night(device: :lab, entity: 'home_alarm')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/alarm_control_panel/home_alarm/arm_night')
    end
  end

  describe '#alarm_arm_vacation' do
    it 'sends POST to arm_vacation' do
      client.alarm_arm_vacation(device: :lab, entity: 'home_alarm')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/alarm_control_panel/home_alarm/arm_vacation')
    end
  end

  describe '#alarm_disarm' do
    it 'sends POST to disarm' do
      client.alarm_disarm(device: :lab, entity: 'home_alarm')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/alarm_control_panel/home_alarm/disarm')
    end

    it 'sends code in POST body' do
      client.alarm_disarm(device: :lab, entity: 'home_alarm', code: '5678')
      expect(WebMock).to have_requested(:post, 'http://10.0.0.1/alarm_control_panel/home_alarm/disarm')
        .with(body: 'code=5678')
    end
  end
end
