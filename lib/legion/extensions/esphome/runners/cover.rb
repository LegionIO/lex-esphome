# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Cover
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def cover_state(device:, entity:, **)
            connection(device: device).get("/cover/#{entity}").body
          end

          def cover_open(device:, entity:, **)
            connection(device: device).post("/cover/#{entity}/open").body
          end

          def cover_close(device:, entity:, **)
            connection(device: device).post("/cover/#{entity}/close").body
          end

          def cover_stop(device:, entity:, **)
            connection(device: device).post("/cover/#{entity}/stop").body
          end

          def cover_toggle(device:, entity:, **)
            connection(device: device).post("/cover/#{entity}/toggle").body
          end

          def cover_set(device:, entity:, position: nil, tilt: nil, **)
            params = { position: position, tilt: tilt }.compact
            connection(device: device).post("/cover/#{entity}/set") do |req|
              req.params = params
            end.body
          end
        end
      end
    end
  end
end
