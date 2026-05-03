# frozen_string_literal: true

require 'faraday'

module Legion
  module Extensions
    module Esphome
      module Helpers
        module Client
          def connection(device:, **opts)
            dev = resolve_device(device)
            build_faraday_connection(dev, opts)
          end

          def resolve_device(device)
            devices = settings[:devices] || {}
            dev = devices[device.to_sym] || devices[device.to_s]
            raise ArgumentError, "unknown ESPHome device: #{device}" unless dev

            { host: dev[:host], port: dev.fetch(:port, 80) }
          end

          private

          def build_faraday_connection(dev, opts)
            timeouts = connection_timeouts(opts)
            Faraday.new("http://#{dev[:host]}:#{dev[:port]}") do |conn|
              conn.options.open_timeout = timeouts[:open_timeout]
              conn.options.read_timeout = timeouts[:read_timeout]
              conn.options.timeout      = timeouts[:timeout]
              conn.response :json, content_type: /\bjson$/
              conn.adapter Faraday.default_adapter
            end
          end

          def connection_timeouts(opts)
            defaults = settings[:options] || {}
            {
              open_timeout: opts.fetch(:open_timeout, defaults[:open_timeout] || 5),
              read_timeout: opts.fetch(:read_timeout, defaults[:read_timeout] || 10),
              timeout: opts.fetch(:timeout, defaults[:timeout] || 10)
            }
          end
        end
      end
    end
  end
end
