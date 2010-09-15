class Run < ActiveRecord::Base
  belongs_to :build
end

class Build < ActiveRecord::Base
  has_many :runs
  
  def self.curl(url)
    `curl -s #{url}`
  end
    
  
  def self.next_to_run
    all.detect { |build| build.should_run? }
  end
  
  def latest_github_hash
    url = "http://github.com/api/v2/yaml/repos/show/#{github_user}/#{github_repository}/branches"
    response = YAML::load(self.class.curl(url))
    response["branches"][git_branch]
  end
  
  def should_run?
    runs.find_by_git_hash(latest_github_hash) == nil
  end
  
  def execute
    run = Run.new(:git_hash => latest_github_hash, :build => self)
    run.output = `#{run_script} 2>&1`
    run.success = $?.to_i == 0
    run.save!
    run
  end
end