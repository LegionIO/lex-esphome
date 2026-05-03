# frozen_string_literal: true

require 'bundler/setup'
require 'webmock/rspec'

module Legion
  module Extensions
    module Helpers
      module Lex; end
    end

    module Actors
      class Poll # rubocop:disable Lint/EmptyClass
      end

      class Base # rubocop:disable Lint/EmptyClass
      end
    end
  end
end

require 'legion/extensions/esphome/client'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'
  config.disable_monkey_patching!
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
