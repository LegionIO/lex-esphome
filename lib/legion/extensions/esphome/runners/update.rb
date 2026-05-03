# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Update
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def update_state(device:, entity:, **)
            connection(device: device).get("/update/#{entity}").body
          end

          def update_install(device:, entity:, **)
            connection(device: device).post("/update/#{entity}/install").body
          end
        end
      end
    end
  end
end
