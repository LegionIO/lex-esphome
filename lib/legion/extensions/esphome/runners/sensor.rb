# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Sensor
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def sensor_state(device:, entity:, detail: nil, **)
            params = detail ? { detail: detail } : {}
            connection(device: device).get("/sensor/#{entity}", params).body
          end
        end
      end
    end
  end
end
