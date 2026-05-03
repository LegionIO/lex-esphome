# frozen_string_literal: true

require_relative 'lib/legion/extensions/esphome/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-esphome'
  spec.version       = Legion::Extensions::Esphome::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']
  spec.summary       = 'LEX::ESPHome'
  spec.description   = 'Connects LegionIO to ESPHome devices via the Web Server REST API'
  spec.homepage      = 'https://github.com/LegionIO/lex-esphome'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/LegionIO/lex-esphome'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-esphome'
  spec.metadata['changelog_uri'] = 'https://github.com/LegionIO/lex-esphome'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/LegionIO/lex-esphome/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '>= 2.0'

  spec.add_dependency 'legion-cache',     '>= 1.3.11'
  spec.add_dependency 'legion-crypt',     '>= 1.4.9'
  spec.add_dependency 'legion-data',      '>= 1.4.17'
  spec.add_dependency 'legion-json',      '>= 1.2.1'
  spec.add_dependency 'legion-logging',   '>= 1.3.2'
  spec.add_dependency 'legion-settings',  '>= 1.3.14'
  spec.add_dependency 'legion-transport', '>= 1.3.9'
end
