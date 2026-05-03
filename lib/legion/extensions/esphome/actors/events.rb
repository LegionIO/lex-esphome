# frozen_string_literal: true

require 'net/http'
require 'json'

module Legion
  module Extensions
    module Esphome
      module Actors
        class Events
          attr_reader :settings, :threads

          def initialize(settings:)
            @settings = settings
            @threads = []
          end

          def start
            devices = settings[:devices] || {}
            devices.each do |name, config|
              @threads << spawn_listener(name.to_sym, config)
            end
          end

          def stop
            @threads.each { |t| t.kill if t.alive? }
            @threads.clear
          end

          private

          def spawn_listener(name, config)
            host = config[:host]
            port = config.fetch(:port, 80)

            Thread.new do
              loop do
                listen(name, host, port)
              rescue StandardError => e
                log_error(name, e)
                sleep 5
              end
            end
          end

          def listen(name, host, port)
            uri = URI("http://#{host}:#{port}/events")
            Net::HTTP.start(uri.host, uri.port, read_timeout: 0) do |http|
              request = Net::HTTP::Get.new(uri)
              request['Accept'] = 'text/event-stream'

              http.request(request) do |response|
                buffer = +''
                response.read_body do |chunk|
                  buffer << chunk
                  while (idx = buffer.index("\n\n"))
                    raw = buffer.slice!(0, idx + 2)
                    handle_event(name, raw)
                  end
                end
              end
            end
          end

          def handle_event(device, raw)
            event_type = nil
            data_lines = []

            raw.each_line do |line|
              line = line.chomp
              if line.start_with?('event:')
                event_type = line.sub('event:', '').strip
              elsif line.start_with?('data:')
                data_lines << line.sub('data:', '').strip
              end
            end

            return unless event_type == 'state'
            return if data_lines.empty?

            payload = ::JSON.parse(data_lines.join, symbolize_names: true)
            process_state_event(device, payload)
          end

          def process_state_event(device, payload)
            return unless defined?(Legion::Transport)

            Legion::Transport.publish(
              routing_key: "esphome.#{device}.state",
              body: { device: device, payload: payload }
            )
          end

          def log_error(name, error)
            if defined?(Legion::Logging)
              Legion::Logging.log.error("ESPHome SSE error for #{name}: #{error.message}")
            else
              warn("ESPHome SSE error for #{name}: #{error.message}")
            end
          end
        end
      end
    end
  end
end
