# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Actors
        class Poll < Legion::Extensions::Actors::Poll
          def runner_class
            Legion::Extensions::Esphome::Runners::Device
          end

          def runner_function
            'info'
          end

          def int_percentage_normalize
            0.005
          end
        end
      end
    end
  end
end
