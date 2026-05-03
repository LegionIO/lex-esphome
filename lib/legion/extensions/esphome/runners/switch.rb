# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Switch
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def switch_state(device:, entity:, **)
            connection(device: device).get("/switch/#{entity}").body
          end

          def switch_turn_on(device:, entity:, **)
            connection(device: device).post("/switch/#{entity}/turn_on").body
          end

          def switch_turn_off(device:, entity:, **)
            connection(device: device).post("/switch/#{entity}/turn_off").body
          end

          def switch_toggle(device:, entity:, **)
            connection(device: device).post("/switch/#{entity}/toggle").body
          end
        end
      end
    end
  end
end
