require 'legion/extensions/transport'
require 'legion/extensions/esphome'

module Legion::Extensions::Esphome
  module Transport
    extend Legion::Extensions::Transport
    def self.additional_e_to_q
      [
        { from: 'esphome', to: 'sensors', routing_key: '#.sensor.#.state' },
        { from: 'esphome', to: 'logs', routing_key: 'esphome.logs.#' }
      ]
    end
  end
end
