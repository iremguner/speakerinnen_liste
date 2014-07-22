require 'spec_helper'

describe Medialink do
  before do
     #@user = FactoryGirl.create(:user)
     @link = Medialink.new(url: 'url.url', title: 'title')
  end
  subject { @link }

  it { should respond_to(:url)}
  it { should respond_to(:title)}
  it { should respond_to(:description)}
  it { should respond_to(:profile)}
  it { should be_valid}

  describe "title should not be empty" do
    before { @link.title = '' }
    it {should_not be_valid}
  end

  describe "url must not be empty" do
    before { @link.url = '' }
    it {should_not be_valid}
  end

  ['http://example.com', 'https://example.com', 'www.example.com','example.com', 'de.example.com'].each do |url|
    describe "valid url #{url}" do
      before { @link.url = url }
      it {should be_valid}
    end

    describe "html output for valid url #{url}" do
      before { @link.url = url }
      it "is correct" do
        expect(@link).to be_valid
        expect(@link.url_html).to match /<p><a href="http(s|):\/\/.*" target="_blank" rel="nofollow">.*<\/a><\/p>/
      end
    end
  end

  ['http:www.example.com', 'http:/www.example.com', 'http//www.example.com',
  'https:www.example.com', 'https:/www.example.com', 'https//www.example.com',
  'ww.example.com', 'wwww.example.com'
  ].each do |invalid|
    describe "invalid url: #{invalid}" do
      before { @link.url = invalid }
      it {should_not be_valid}
    end
  end



end
