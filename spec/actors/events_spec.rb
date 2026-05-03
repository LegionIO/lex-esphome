# frozen_string_literal: true

require 'spec_helper'
require 'legion/extensions/esphome/actors/events'

RSpec.describe Legion::Extensions::Esphome::Actors::Events do
  let(:settings) do
    {
      devices: {
        lab: { host: '10.0.0.1', port: 80 }
      }
    }
  end

  subject(:actor) { described_class.new(settings: settings) }

  describe '#initialize' do
    it 'stores settings' do
      expect(actor.settings).to eq(settings)
    end

    it 'starts with empty threads' do
      expect(actor.threads).to be_empty
    end
  end

  describe '#stop' do
    it 'clears threads' do
      actor.stop
      expect(actor.threads).to be_empty
    end
  end

  describe '#handle_event (via send)' do
    it 'parses state events' do
      raw = "event: state\ndata: {\"id\":\"sensor/temp\",\"state\":\"22\"}\n\n"
      expect { actor.send(:handle_event, :lab, raw) }.not_to raise_error
    end

    it 'ignores ping events' do
      raw = "event: ping\ndata: \n\n"
      expect { actor.send(:handle_event, :lab, raw) }.not_to raise_error
    end

    it 'ignores log events' do
      raw = "event: log\ndata: some log line\n\n"
      expect { actor.send(:handle_event, :lab, raw) }.not_to raise_error
    end
  end
end
