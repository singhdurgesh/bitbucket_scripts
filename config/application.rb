# frozen_string_literal: true

require 'httparty'
require 'byebug'
require 'i18n'
require 'yaml'
require_relative 'configuration'
require_relative '../lib/models/pull_request'
require_relative '../lib/models/repository'

# Initialize application
class Application
  # Initialze configurations
  Configuration.set_keys
end
