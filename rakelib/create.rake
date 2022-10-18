# frozen_string_literal: true

namespace :pull_requests do
  task :create do
    project_name, repository_name, source_branch, destination_branch = sanitize_env_variables_for_pull_request

    create_pull_request(project_name, repository_name, source_branch, destination_branch)
  end

  def create_pull_request(project_name, repository_name, source_branch, destination_branch)
    repository = Repository.new(name: repository_name, project_name: project_name)
    title, description = get_pull_request_title_and_description(repository_name, source_branch, destination_branch)

    reviewer_uuids = reviewer_uuids_from_env_variables
    response = PullRequest.create_pull_request(repository, title, description, destination_branch, source_branch, reviewer_uuids)
    pp response
  end

  def get_pull_request_title_and_description(repository_name, source_branch, destination_branch)
    title = "#{source_branch.capitalize} to #{destination_branch.capitalize} on #{Date.today.strftime('%b %d, %Y')}"

    description_file_name = "#{Date.today.strftime('%Y_%m_%d')}_#{repository_name}_pull_request_description.md"
    description_file_path = File.join(Configuration.value_of('temp_dir'), description_file_name)

    description =
      if File.exist?(description_file_path)
        File.read(description_file_path)
      elsif !ENV['PULL_REQUEST_DESCRIPTION'].nil?
        ENV['PULL_REQUEST_DESCRIPTION']
      else
        raise "Description file #{description_file_path} does not exist"
      end

    [title, description]
  end

  def reviewer_uuids_from_env_variables
    return [] if ENV['REVIEWERS'].nil?

    ENV['REVIEWERS'].split(',').map(&:strip)
  end

  def sanitize_env_variables_for_pull_request
    [
      ENV['PROJECT'] || 'durgesh_snigh',
      ENV['REPOSITORY'] || 'bitbucket_scripts',
      ENV['SOURCE_BRANCH'] || 'development',
      ENV['DESTINATION_BRANCH'] || 'master'
    ]
  end
end
