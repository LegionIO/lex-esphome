# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Fan
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def fan_state(device:, entity:, **)
            connection(device: device).get("/fan/#{entity}").body
          end

          def fan_turn_on(device:, entity:, speed_level: nil, oscillation: nil, **)
            params = { speed_level: speed_level, oscillation: oscillation }.compact
            connection(device: device).post("/fan/#{entity}/turn_on") do |req|
              req.params = params
            end.body
          end

          def fan_turn_off(device:, entity:, **)
            connection(device: device).post("/fan/#{entity}/turn_off").body
          end

          def fan_toggle(device:, entity:, **)
            connection(device: device).post("/fan/#{entity}/toggle").body
          end
        end
      end
    end
  end
end
