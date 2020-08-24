module Legion
  module Extensions
    module Esphome
      module Runners
        module Sensors
          def self.process(value:, **payload) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/AbcSize,Metrics/PerceivedComplexity
            items = payload[:routing_key].split('.')

            subtype = if items[2].include?('fan')
                        'fan'
                      elsif items[2].include?('voltage')
                        'voltage'
                      elsif items[2].include?('temp')
                        'temperature'
                      elsif items[2].include?('humidity')
                        'humidity'
                      elsif items[2].include?('wifi_signal')
                        'wifi_signal'
                      elsif items[2].include?('uptime')
                        'uptime'
                      elsif items[2].include?('pressure')
                        'pressure'
                      elsif items[2].include?('pulse')
                        'pulse'
                      elsif items[2].include?('meter')
                        'meter'
                      elsif items[2].include?('brightness')
                        'brightness'
                      elsif items[2].include?('illuminance') || items[2].include?('lx') || items[2].include?('bright')
                        'illuminance'
                      elsif items[2].include?('current')
                        'current'
                      end

            if subtype.nil?
              log.warn("Subtype was not found for esphome item subtype: #{items[2]}")
              subtype = items[2]
            elsif subtype == 'temperature'
              value = ((value.to_i * 9 / 5) + 32).round(3) if settings[:convert_c_to_f]
            end

            {
              value:           value,
              name:            items[0],
              type:            items[2],
              sub_type:        subtype,
              item:            items[3],
              timestamp_in_ms: payload[:timestamp_in_ms]
            }
          end

          include Legion::Extensions::Helpers::Lex
        end
      end
    end
  end
end
