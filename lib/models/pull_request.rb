# frozen_string_literal: true

require_relative 'bitbucket_api_base'

# Module for fetching pull requests details for a given repo with Bitbucket
#
# Author: Durgesh Singh :)
class PullRequest < BitbucketApiBase
  PULL_REQUEST_URL = 'https://api.bitbucket.org/2.0/repositories/%{project}/%{repository}/pullrequests'

  attr_accessor :repository, :pull_request_id

  # Methods to fetch all pull requests for a given repo
  def self.fetch_pull_requests(repository)
    request_url = PULL_REQUEST_URL % { project: repository.project_name, repository: repository.name }
    response = HTTParty.get(request_url, headers: headers)
    response.parsed_response
  end
end
