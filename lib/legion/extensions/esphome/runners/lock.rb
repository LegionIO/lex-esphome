# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Lock
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def lock_state(device:, entity:, **)
            connection(device: device).get("/lock/#{entity}").body
          end

          def lock_lock(device:, entity:, **)
            connection(device: device).post("/lock/#{entity}/lock").body
          end

          def lock_unlock(device:, entity:, **)
            connection(device: device).post("/lock/#{entity}/unlock").body
          end

          def lock_open(device:, entity:, **)
            connection(device: device).post("/lock/#{entity}/open").body
          end
        end
      end
    end
  end
end
