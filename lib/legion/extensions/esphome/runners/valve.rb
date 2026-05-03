# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Valve
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def valve_state(device:, entity:, **)
            connection(device: device).get("/valve/#{entity}").body
          end

          def valve_open(device:, entity:, **)
            connection(device: device).post("/valve/#{entity}/open").body
          end

          def valve_close(device:, entity:, **)
            connection(device: device).post("/valve/#{entity}/close").body
          end

          def valve_toggle(device:, entity:, **)
            connection(device: device).post("/valve/#{entity}/toggle").body
          end

          def valve_set(device:, entity:, position:, **)
            connection(device: device).post("/valve/#{entity}/set") do |req|
              req.params = { position: position }
            end.body
          end
        end
      end
    end
  end
end
