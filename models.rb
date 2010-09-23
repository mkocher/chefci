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

class Run < ActiveRecord::Base
  belongs_to :build
end

class Build < ActiveRecord::Base
  has_many :runs
  has_many :git_repos
  
  def self.next_to_run
    all.detect { |build| build.should_run? }
  end
  
  def latest_hashes
    git_repos.order("id").map{|repo| repo.latest_hash }.join("_")
  end
  
  def should_run?
    runs.find_by_git_hash(latest_hashes) == nil
  end
  
  def building?
    last_run.in_progress?
  end
  
  def execute
    run = Run.new(:git_hash => latest_hashes, :build => self)
    run.in_progress = true
    run.save!
    command = "unset #{env_vars_to_unset.join(" ")} && PATH=#{pre_bundler_path} #{run_script}"
    run.output = `#{command}`
    run.success = $?.to_i == 0
    run.in_progress = false
    run.save!
    run
  end
  
  def last_run
    runs.last
  end

  def pre_bundler_path
    ENV['PATH'] && ENV["PATH"].split(":").reject { |path| path.include?("vendor") }.join(":")
  end

  def env_vars_to_unset
    ["RUBYOPT", "BUNDLE_BIN_PATH", "BUNDLE_GEMFILE", "GEM_HOME"]
  end
end
