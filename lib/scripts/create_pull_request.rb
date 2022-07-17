# frozen_string_literal: true

load 'config/application.rb'

# Module to create pull requests for a given repo with Bitbucket
module CreatePullRequest
  # Module to create pull request for a given repo with Bitbucket
  #
  repository = Repository.new(name: 'bitbucket_scripts', project_name: 'durgesh_snigh')

  repostory_details = repository.fetch_repository_details
  pp repostory_details

  pull_requests = PullRequest.fetch_pull_requests(repository)
  pp pull_requests

  pull_request = PullRequest.new(repository: repository, pull_request_id: 1)

  details = pull_request.fetch_pull_request_details
  pp details

  # # Request to create a pull request
  title = 'Add new feature, PR created from Ruby script'
  source_branch = 'improve/add-func-for-decline-and-merge-pr'
  destination_branch = 'development'
  description = 'This is a test pull request'

  pp 'Sending the request to generate PULL Request'
  response = PullRequest.create_pull_request(repository, title, description, destination_branch, source_branch)
  pp response

  pull_request = PullRequest.new(repository: repository, pull_request_id: '10')
  response = pull_request.decline_pull_request
  pp response

  puts 'Sending the request to Merge  the PULL Request'
  type = 'MERGE'
  message = 'PR is being merged with a Script'
  close_source_branch = true
  merge_strategy = 'merge_commit'
  pull_request = PullRequest.new(repository: repository, pull_request_id: '10')
  response = pull_request.merge_pull_request(type, message, close_source_branch, merge_strategy)
  pp response
end
