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

  # Request to create a pull request
  title = 'Add new feature, PR created from Ruby script'
  source_branch = 'add/create-pr-script'
  destination_branch = 'master'
  description = 'This is a test pull request'

  response = PullRequest.create_pull_request(repository, title, description, destination_branch, source_branch)
  pp response
end
