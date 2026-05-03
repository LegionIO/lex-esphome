# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Number
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def number_state(device:, entity:, **)
            connection(device: device).get("/number/#{entity}").body
          end

          def number_set(device:, entity:, value:, **)
            connection(device: device).post("/number/#{entity}/set") do |req|
              req.params = { value: value }
            end.body
          end
        end
      end
    end
  end
end
