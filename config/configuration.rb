# frozen_string_literal: true

require 'yaml'

# Initialize application
class Configuration
  @config = {}

  class << self
    def set_keys
      configurations = YAML.load_file('config/application.yml')
      configurations['bitbucket_info'].each do |key, value|
        @config[key] = value unless key.nil? || value.nil?
      end
    end

    def value_of(key)
      @config[key]
    end

    def set_value(key, value)
      @config[key] = value unless key.nil? || value.nil?
    end
  end
end
