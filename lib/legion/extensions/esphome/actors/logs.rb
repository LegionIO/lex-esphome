module Legion
  module Extensions
    module Esphome
      module Actor
        class Logs < Legion::Extensions::Actors::Subscription
          def runner_function
            'process'
          end

          def include_metadata_in_message?
            true
          end

          def generate_task?
            false
          end
        end
      end
    end
  end
end
