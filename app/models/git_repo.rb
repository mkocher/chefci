
class GitRepo < ActiveRecord::Base
  belongs_to :build
  def self.curl(url)
    `curl -s #{url}`
  end
    
  def latest_hash
    url = "http://github.com/api/v2/yaml/repos/show/#{github_user}/#{github_repository}/branches"
    response = YAML::load(self.class.curl(url))
    response["branches"][git_branch]
  end
end