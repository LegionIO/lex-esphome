# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module BinarySensor
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def binary_sensor_state(device:, entity:, detail: nil, **)
            params = detail ? { detail: detail } : {}
            connection(device: device).get("/binary_sensor/#{entity}", params).body
          end
        end
      end
    end
  end
end
