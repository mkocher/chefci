require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Build do
  before do
    clear_storage
    @repo = GitRepo.new(:github_user => "pivotalexperimental", :github_repository => "wschef", :git_branch => "master")
    @build = Build.new(:run_script => "", :git_repos => [@repo], :name => "Basic Build")
    @build.save!
    GitRepo.stub(:curl).and_return "--- \nbranches: \n  master: DEADBEEF\n  broken_vim: df38014730975b9d18ee7fb969a247dac0b09ace\n"
  end
  
  it "exists" do
    @build.should be_valid
  end
  
  it "should be able to get the latest hashes with one git repo" do
    @build.latest_hashes.should == "DEADBEEF"
  end
  
  it "should be able to get the latest hashes with two git repos" do
    @repo = GitRepo.new(:github_user => "pivotalexperimental", :github_repository => "ci_cookbook", :git_branch => "master")
    @build.git_repos << @repo
    @build.save
    @build.latest_hashes.should == "DEADBEEF_DEADBEEF"
  end
  
  it "knows if it should run or not" do
    @build.save
    @build.should_run?.should be_true
    @build.runs << Run.new(:git_hash => "DEADBEEF", :success => true)
    @build.should_run?.should be_false
  end
  
  it "can find the next build to run" do 
    @build.save
    Build.next_to_run.id.should == @build.id
  end
  
  it "has a name method" do
    @build.name.should == "Basic Build"
  end
  
  it "can find the last run" do
    @build.runs << Run.new(:git_hash => "DEADBEEF", :success => true)
    @build.runs << Run.new(:git_hash => "SUCCESS", :success => false)
    @build.last_run.git_hash.should == "SUCCESS"
    @build.last_run.success.should == false
  end
  
  it "knows if it's building" do
    pending
    half_run = Run.new(:git_hash => @build.latest_github_hash, :build => @build)
    half_run.stub(:in_progress=).and_return(lambda{|values| true })
    Run.stub(:new).and_return(half_run)
    @build.execute
    @build.building?.should be_true
  end
  
  describe "building a build" do
    it "can execute a build script" do
      @build.run_script = "echo foobar"
      run = @build.execute
      run.output.should include("foo")
      run.success.should be_true
    end
    
    it "knows if the job failed" do
      @build.run_script = "exit 1"
      run = @build.execute
      run.success.should be_false
    end
    
    it "gets standard error" do
      pending
      # SORRY: This functionality was removed during development.  I need to try it again
      @build.run_script = "ls /this_file_should_not_exist"
      run = @build.execute
      run.output.should include("No such file or directory")
    end
  end 
end

describe Run do
  before do
    clear_storage
    @build = Build.new
    @run = Run.new(:git_hash => "DEADBEEF", :success => true)
    Build.stub(:curl).and_return "--- \nbranches: \n  master: DEADBEEF\n  broken_vim: df38014730975b9d18ee7fb969a247dac0b09ace\n"
  end
  
  it "belongs to a build" do
    @run.build = @build
    @run.should be_valid
  end
end

describe GitRepo do
  before do
    clear_storage
    # @build = Build.new
    # @run = Run.new(:git_hash => "DEADBEEF", :success => true)
    GitRepo.stub(:curl).and_return "--- \nbranches: \n  master: DEADBEEF\n  broken_vim: df38014730975b9d18ee7fb969a247dac0b09ace\n"
  end
  
  it "can get its latest hash" do
    @repo = GitRepo.new(:github_user => "pivotalexperimental", :github_repository => "wschef", :git_branch => "master")
    @repo.latest_hash.should == "DEADBEEF"
  end
end