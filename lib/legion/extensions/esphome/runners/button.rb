# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Button
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def button_press(device:, entity:, **)
            connection(device: device).post("/button/#{entity}/press").body
          end
        end
      end
    end
  end
end
