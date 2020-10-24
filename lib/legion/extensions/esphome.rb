require 'legion/extensions/esphome/version'

module Legion
  module Extensions
    module Esphome
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
