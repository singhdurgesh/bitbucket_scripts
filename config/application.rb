# frozen_string_literal: true

require 'httparty'
require 'byebug'
require 'i18n'
require 'yaml'
load 'config/configuration.rb'

# Initialize application
class Application
  # Initialze configurations
  Configuration.set_keys
end
