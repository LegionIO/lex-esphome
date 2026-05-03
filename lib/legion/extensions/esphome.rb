# frozen_string_literal: true

require 'legion/extensions/esphome/version'

module Legion
  module Extensions
    module Esphome
      extend Legion::Extensions::Core if Legion::Extensions.const_defined?(:Core, false)

      def self.default_settings
        {
          devices: {},
          options: {
            open_timeout: 5,
            read_timeout: 10,
            timeout: 10
          },
          events: {
            enabled: true
          },
          discovery: {
            enabled: false,
            interval: 300
          }
        }
      end
    end
  end
end
