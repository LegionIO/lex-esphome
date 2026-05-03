# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module Device
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def device_info(device:, **)
            connection(device: device).get('/').body
          end

          def discover_mdns(**)
            require 'dnssd'

            devices = []
            browse = DNSSD.browse!('_esphomelib._tcp') do |reply|
              DNSSD.resolve!(reply) do |resolved|
                devices << {
                  name: reply.name,
                  host: resolved.target,
                  port: resolved.port
                }
                resolved.service.stop
              end
              reply.service.stop if devices.size >= 50
            end

            sleep 3
            browse.stop
            devices
          rescue LoadError
            raise LoadError, 'dnssd gem is required for mDNS discovery: gem install dnssd'
          end
        end
      end
    end
  end
end
