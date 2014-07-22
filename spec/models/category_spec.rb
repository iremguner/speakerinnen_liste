require 'spec_helper'

describe Category do
  before do
     #@user = FactoryGirl.create(:user)
     @category = Category.new(name: 'name')
  end
  subject { @category }

  it { should respond_to(:name)}
  it { should respond_to(:tags)}
  it { should be_valid}

  describe "name should not be empty" do
    before { @category.name = '' }
    it {should_not be_valid}
  end

  describe "is persisted" do
    before { @category.save! }
    it "in the database" do
      expect(Category.count).to be 1
      Category.where(name: 'name').should_not be_nil
    end
    it "and is destroyable" do
      @category.destroy
      expect(Category.count).to be 0
    end
  end
end
