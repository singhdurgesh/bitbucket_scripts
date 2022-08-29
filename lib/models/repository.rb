# frozen_string_literal: true

require_relative 'bitbucket_api_base'

# Module for fetching repository details for a given repo with Bitbucket
#
# Author: Durgesh Singh :)
class Repository < BitbucketApiBase
  BASE_PROJECT_URL = 'https://api.bitbucket.org/2.0/repositories/%<project>s'
  BASE_REPOSITORY_URL = 'https://api.bitbucket.org/2.0/repositories/%<project>s/%<repository>s'

  attr_accessor :name, :project_name

  def initialize(options = {})
    self.name = options[:name]
    self.project_name = options[:project_name]
    super
  end

  # Fetch the list of all repositories for a given project
  def self.fetch_repositories_list(project_name)
    request_url = format(BASE_PROJECT_URL, project: project_name)
    response = HTTParty.get(request_url, headers: headers)
    response.parsed_response
  end

  # Fetch the data for a given repository
  def fetch_repository_details
    request_url = format(BASE_REPOSITORY_URL, project: project_name, repository: name)
    response = HTTParty.get(request_url, headers: self.class.headers)
    response.parsed_response
  end
end
