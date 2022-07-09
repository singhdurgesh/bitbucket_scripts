# frozen_string_literal: true

# Base class for all Bitbucket API classes
class BitbucketApiBase
  BASE_URL = 'https://api.bitbucket.org/2.0/'
  AUTH_HEADER_KEY = 'Authorization'

  def initialize(options = {})
  end

  def self.headers
    headers = {}
    headers[AUTH_HEADER_KEY] = Configuration.value_of('auth_token')
    headers
  end
end
