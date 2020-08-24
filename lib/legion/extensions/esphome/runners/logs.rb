module Legion
  module Extensions
    module Esphome
      module Runners
        module Logs
          def self.process(value:, **payload)
            {
              log:             value.gsub(/\e\[([;\d]+)?m/, ''),
              location:        payload[:routing_key].split('.').last,
              timestamp_in_ms: payload[:timestamp_in_ms]
            }
          end

          include Legion::Extensions::Helpers::Lex
        end
      end
    end
  end
end
