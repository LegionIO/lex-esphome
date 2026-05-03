# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Climate
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def climate_state(device:, entity:, **)
            connection(device: device).get("/climate/#{entity}").body
          end

          def climate_set(device:, entity:, mode: nil, target_temperature: nil, # rubocop:disable Metrics/ParameterLists
                          target_temperature_low: nil, target_temperature_high: nil, fan_mode: nil, **)
            params = { mode: mode, target_temperature: target_temperature,
                       target_temperature_low: target_temperature_low,
                       target_temperature_high: target_temperature_high,
                       fan_mode: fan_mode }.compact
            connection(device: device).post("/climate/#{entity}/set") do |req|
              req.params = params
            end.body
          end
        end
      end
    end
  end
end
