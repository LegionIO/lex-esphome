# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Select
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def select_state(device:, entity:, detail: nil, **)
            params = detail ? { detail: detail } : {}
            connection(device: device).get("/select/#{entity}", params).body
          end

          def select_set(device:, entity:, option:, **)
            connection(device: device).post("/select/#{entity}/set") do |req|
              req.params = { option: option }
            end.body
          end
        end
      end
    end
  end
end
