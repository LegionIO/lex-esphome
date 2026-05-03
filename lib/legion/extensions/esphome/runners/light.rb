# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Light
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def light_state(device:, entity:, **)
            connection(device: device).get("/light/#{entity}").body
          end

          def light_turn_on(device:, entity:, brightness: nil, red: nil, green: nil, blue: nil, # rubocop:disable Metrics/ParameterLists
                            white_value: nil, color_temp: nil, effect: nil, transition: nil, flash: nil, **)
            params = { brightness: brightness, r: red, g: green, b: blue, white_value: white_value,
                       color_temp: color_temp, effect: effect, transition: transition, flash: flash }.compact
            connection(device: device).post("/light/#{entity}/turn_on") do |req|
              req.params = params
            end.body
          end

          def light_turn_off(device:, entity:, transition: nil, **)
            params = { transition: transition }.compact
            connection(device: device).post("/light/#{entity}/turn_off") do |req|
              req.params = params
            end.body
          end

          def light_toggle(device:, entity:, **)
            connection(device: device).post("/light/#{entity}/toggle").body
          end
        end
      end
    end
  end
end
