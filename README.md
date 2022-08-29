# Handle Basic Bitbucket Repo Actions using [REST APIs](https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-group-pullrequests) with Command Line or Simple Ruby Script


## Description
Bitbucket provides its [rest apis](https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-group-pullrequests). We will be using it for simple pull requests actions like
- Create a Pull Request
  - With Normal Description
  - Markdown Formatted Description [Reference](https://confluence.atlassian.com/bitbucketserver/markdown-syntax-guide-776639995.html)
- Merge a Pull Request
- Decline a Pull Request
- Fetch details about a Pull Request
- Fetch all active Pull Requests for a given Repository

**NOTE:** We will be authenticating the APIs with Basic Auth. Here Bitbucket username will be used as username and for password you have to create an [App Password](https://developer.atlassian.com/cloud/bitbucket/rest/intro/#app-passwords) with required permissions. Follow the steps provided [here](https://developer.atlassian.com/cloud/bitbucket/rest/intro/#create-an-app-password) to generate an App Password.

---

## Integration

1. Clone this Repository
    > git clone git@bitbucket.org:durgesh_snigh/bitbucket_scripts.git
2. Add application.yml file to add username and app password
    > cp config/application.ci.yml config/application.yml
    - Add Project, repository details and for Auth, add Username and [App Password](https://developer.atlassian.com/cloud/bitbucket/rest/intro/#app-passwords) ([Steps to Generate](https://developer.atlassian.com/cloud/bitbucket/rest/intro/#create-an-app-password)) in the config/application.yml file
3. Install Ruby with your current
   - Install HTTParty Library

---

## How to Use
### With Ruby Scripts
  - Refer create_pull_request.rb
  - Run the script with follwing command from the terminal
    > ruby lib/scripts/create_pull_request.rb
### With IRB
  - Open IRB console with irb command in Linux Terminals in the Current Repo
  - load the application file
    > load config/application.rb
  - Initialize a repository
    > repository = Repository.new(name: 'bitbucket_scripts', project_name: 'durgesh_snigh')
  - Initialize a pull request
    > pull_request = PullRequest.new(repository: repository, pull_request_id: \<Pull Request id>)
  - Fetch the pull request details
    > details = pull_request.fetch_pull_request_details
    > puts details
  - Refer [lib/scripts/create_pull_request.rb](TODO: Add link to the file) for more functionalities

## Resources

- [https://developer.atlassian.com/cloud/jira/platform/basic-auth-for-rest-apis/#supply-basic-auth-headers](https://developer.atlassian.com/cloud/jira/platform/basic-auth-for-rest-apis/#supply-basic-auth-headers)
- [https://confluence.atlassian.com/bitbucketserver/markdown-syntax-guide-776639995.html](https://confluence.atlassian.com/bitbucketserver/markdown-syntax-guide-776639995.html)
- [https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-group-pullrequests](https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-group-pullrequests)
- [https://developer.atlassian.com/cloud/bitbucket/rest/intro/#authentication](https://developer.atlassian.com/cloud/bitbucket/rest/intro/#authentication)
- [https://developer.atlassian.com/cloud/bitbucket/rest/intro/#app-passwords](https://developer.atlassian.com/cloud/bitbucket/rest/intro/#app-passwords)
- [https://developer.atlassian.com/cloud/bitbucket/rest/intro/#create-an-app-password](https://developer.atlassian.com/cloud/bitbucket/rest/intro/#create-an-app-password)
