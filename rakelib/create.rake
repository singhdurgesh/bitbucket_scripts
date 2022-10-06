# frozen_string_literal: true

namespace :pull_requests do
  task :create do
    project_name, repository_name, source_branch, destination_branch = sanitize_env_variables_for_pull_request

    create_pull_request(project_name, repository_name, source_branch, destination_branch)
  end

  def create_pull_request(project_name, repository_name, source_branch, destination_branch)
    repository = Repository.new(name: repository_name, project_name: project_name)
    title = "#{source_branch.capitalize} to #{destination_branch.capitalize} on #{Date.today.strftime('%b %d, %Y')}"
    temp_dir = Configuration.value_of(:root_dir_path) + '/tmp'
    description_file_name = "#{Date.today.strftime('%Y_%m_%d')}_#{repository_name}_pull_request_description.md"
    description_file = File.join(temp_dir, description_file_name)

    description =
      if File.exist?(description_file)
        File.read(description_file)
      else
        raise "Description file #{description_file} does not exist"
      end

    response = PullRequest.create_pull_request(repository, title, description, destination_branch, source_branch)
    pp response
  end

  def sanitize_env_variables_for_pull_request
    [
      ENV['project_name'] || 'durgesh_snigh',
      ENV['repository_name'] || 'bitbucket_scripts',
      ENV['source_branch'] || 'development',
      ENV['destination_branch'] || 'master'
    ]
  end
end
