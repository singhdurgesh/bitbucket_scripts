# frozen_string_literal: true

require_relative 'bitbucket_api_base'

# Module for fetching pull requests details for a given repo with Bitbucket
#
# Author: Durgesh Singh :)
class PullRequest < BitbucketApiBase
  # APIs Source => https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-group-pullrequests
  PULL_REQUEST_URL = 'https://api.bitbucket.org/2.0/repositories/%<project>s/%<repository>s/pullrequests'
  LOCATIONS = [
    SHOW = '/%<pull_request_id>s',
    DECLINE = '/%<pull_request_id>s/decline',
    MERGE = '/%<pull_request_id>s/merge'
  ].freeze

  attr_accessor :repository, :pull_request_id

  def initialize(options = {})
    self.repository = options[:repository]
    self.pull_request_id = options[:pull_request_id].to_i
    super
  end

  # Methods to fetch all pull requests for a given repo
  def self.fetch_pull_requests(repository)
    request_url = format(PULL_REQUEST_URL, project: repository.project_name, repository: repository.name)
    response = HTTParty.get(request_url, headers: headers)
    response.parsed_response
  end

  def self.create_pull_request(repository, title, body, target_branch, source_branch, reviewers_uuids = [])
    request_url = format(PULL_REQUEST_URL, project: repository.project_name, repository: repository.name)
    body = {
      title: title,
      description: body,
      source: { branch: { name: source_branch } },
      destination: { branch: { name: target_branch } }
    }

    body[:reviewers] = reviewers_uuids.map { |uuid| { uuid: uuid } } unless reviewers_uuids.empty?

    response = HTTParty.post(request_url, headers: headers, body: body.to_json)
    response.parsed_response
  end

  def fetch_pull_request_details
    request_url = format(PULL_REQUEST_URL, project: repository.project_name,
                                           repository: repository.name) + "/#{pull_request_id}"

    response = HTTParty.get(request_url, headers: self.class.headers)
    response.parsed_response
  end

  # Methods to Decline a Pull Request
  def decline_pull_request
    request_url = format(PULL_REQUEST_URL + DECLINE, project: repository.project_name, repository: repository.name,
                                                     pull_request_id: pull_request_id)

    headers = { 'Authorization' => self.class.headers['Authorization'] }
    response = HTTParty.post(request_url, headers: headers)
    response.parsed_response
  end

  def merge_pull_request(type, message, close_source_branch = true, merge_strategy = 'merge_commit')
    request_url = format(PULL_REQUEST_URL + MERGE, project: repository.project_name, repository: repository.name,
                                                   pull_request_id: pull_request_id)

    body = {
      type: type,
      message: message,
      close_source_branch: close_source_branch,
      merge_strategy: merge_strategy
    }

    response = HTTParty.post(request_url, headers: self.class.headers, body: body.to_json)
    pp response
  end
end
