
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
