# frozen_string_literal: true

require 'faraday'

unless defined?(Legion::Extensions::Helpers::Lex)
  module Legion
    module Extensions
      module Helpers
        module Lex; end
      end
    end
  end
end

require_relative 'helpers/client'
require_relative 'runners/sensor'
require_relative 'runners/binary_sensor'
require_relative 'runners/switch'
require_relative 'runners/light'
require_relative 'runners/fan'
require_relative 'runners/cover'
require_relative 'runners/select'
require_relative 'runners/button'
require_relative 'runners/number'
require_relative 'runners/climate'
require_relative 'runners/lock'
require_relative 'runners/text'
require_relative 'runners/media_player'
require_relative 'runners/alarm_control_panel'
require_relative 'runners/update'
require_relative 'runners/valve'
require_relative 'runners/device'

module Legion
  module Extensions
    module Esphome
      class Client
        include Helpers::Client
        include Runners::Sensor
        include Runners::BinarySensor
        include Runners::Switch
        include Runners::Light
        include Runners::Fan
        include Runners::Cover
        include Runners::Select
        include Runners::Button
        include Runners::Number
        include Runners::Climate
        include Runners::Lock
        include Runners::Text
        include Runners::MediaPlayer
        include Runners::AlarmControlPanel
        include Runners::Update
        include Runners::Valve
        include Runners::Device

        attr_reader :opts

        def initialize(devices: {}, **opts)
          @devices = devices.transform_keys(&:to_sym).transform_values do |v|
            v.is_a?(Hash) ? v.transform_keys(&:to_sym) : v
          end
          @opts = {
            open_timeout: opts.fetch(:open_timeout, 5),
            read_timeout: opts.fetch(:read_timeout, 10),
            timeout: opts.fetch(:timeout, 10)
          }
        end

        def settings
          { devices: @devices, options: @opts }
        end
      end
    end
  end
end
