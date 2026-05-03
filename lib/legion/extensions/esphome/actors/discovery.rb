# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Actors
        class Discovery < Legion::Extensions::Actors::Poll
          def runner_class
            Legion::Extensions::Esphome::Runners::Device
          end

          def runner_function
            'discover_mdns'
          end

          def int_percentage_normalize
            0.001
          end
        end
      end
    end
  end
end
