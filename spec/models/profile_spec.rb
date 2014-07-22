require 'spec_helper'

describe Profile do
  before do
     #@user = FactoryGirl.create(:user)
     @user = Profile.new(email: 'email@d.c', password: 'password')
     @user2 = Profile.new(email: 'email@d.c', password: 'password')
  end
  subject { @user }

  it { should respond_to(:email)}
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)}
  it { should respond_to(:remember_me)}
  it { should respond_to(:bio)}
  it { should respond_to(:city)}
  it { should respond_to(:firstname)}
  it { should respond_to(:lastname)}
  it { should respond_to(:languages)}
  it { should respond_to(:picture)}
  it { should respond_to(:twitter)}
  it { should respond_to(:remove_picture)}
  it { should respond_to(:website)}
  it { should respond_to(:topic_list)}
  it { should respond_to(:medialinks)}
  it { should respond_to(:main_topic)}
  it { should respond_to(:admin_comment)}

  #are these attributes still in use?
  #it { should respond_to(:media_url)}
  #it { should respond_to(:talks)}
  #it { should respond_to(:content)}
  #it { should respond_to(:name)}
  #it { should respond_to(:translations_attributes)}

  it { should be_valid}
  it { should_not be_admin}

  describe "email should not" do
    describe "be empty" do
      before { @user.email = '' }
      it {should_not be_valid}
    end
    describe "be duplicate" do
      before { @user2.save }
      it {should_not be_valid}
    end
    ['email','email@', 'email@d', 'email@d.',
      '@d', '@d.','@d.c','d.c'].each do |invalid|
      describe "be invalid like #{invalid}" do
        before { @user.email = invalid }
        it {should_not be_valid}
      end
    end
  end

  # part of https://github.com/rubymonsters/speakerinnen_liste/issues/285
  #describe "languages should not " do
  #  describe "be empty" do
  #    before { @user.languages = '' }
  #    it {should_not be_valid}
  #  end
  #end

  describe "admin? is true if it is an admin user" do
    before { @user.admin = true }
    it { should be_admin}
  end

  describe "fullname is assembled corretly" do
    before do
      @user.firstname = ' first 2nd '
      @user.lastname = ' last-last '
    end
    it "should even work with spaces in the fields" do
      expect(@user.fullname).to eq 'first 2nd last-last'
    end
  end

  describe "profile from twitter omniauth" do
    before do
      h = Hashie::Mash.new({:provider => "twitter", :uid => "uid", :info => {:nickname => "nickname", :name => "Maren"}})
      @profile = Profile.from_omniauth(h)
    end
    it "is properly built" do
      expect(@profile.uid).to eq 'uid'
      expect(@profile.twitter).to eq 'nickname'
    end
  end

  describe "twitter @ symbol" do
    before { @user.twitter = '@tweeter'}
    it "is correctly removed" do
      expect(@user).to be_valid
      expect(@user.twitter).to eq 'tweeter'
    end
  end
end
