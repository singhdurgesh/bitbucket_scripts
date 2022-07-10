# frozen_string_literal: true

require_relative 'bitbucket_api_base'

# Module for fetching pull requests details for a given repo with Bitbucket
#
# Author: Durgesh Singh :)
class PullRequest < BitbucketApiBase
  PULL_REQUEST_URL = 'https://api.bitbucket.org/2.0/repositories/%{project}/%{repository}/pullrequests'

  attr_accessor :repository, :pull_request_id

  def initialize(options = {})
    self.repository = options[:repository]
    self.pull_request_id = options[:pull_request_id]
    super
  end

  # Methods to fetch all pull requests for a given repo
  def self.fetch_pull_requests(repository)
    request_url = PULL_REQUEST_URL % { project: repository.project_name, repository: repository.name }
    response = HTTParty.get(request_url, basic_auth: authentication_hash)
    response.parsed_response
  end

  def self.create_pull_request(repository, title, body, target_branch, source_branch)
    request_url = PULL_REQUEST_URL % { project: repository.project_name, repository: repository.name }
    body = {
      title: title,
      description: body,
      source: { branch: source_branch },
      destination: { branch: target_branch }
    }

    response = HTTParty.post(request_url, basic_auth: authentication_hash, body: body, type: :json)
    response.parsed_response
  end

  def fetch_pull_request_details
    request_url = PULL_REQUEST_URL % { project: repository.project_name, repository: repository.name } + "/#{pull_request_id}"

    response = HTTParty.get(request_url, basic_auth: self.class.authentication_hash)
    # response = HTTParty.get(request_url, headers: self.class.headers)
    response.parsed_response
  end
end
