require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Question do
  before(:each) do
    @valid_attributes = {
      :content => "value for content",
      :identity_url => "value for identity_url"
    }
  end

  it "should create a new instance given valid attributes" do
    Question.create!(@valid_attributes)
  end
end

describe Question, "#owner_regexs=" do
  before do
    @regexs = "http://hoge.*,https://*"
    @question = Question.new
    @question.owner_regexs = @regexs
  end
  it "questionにowner_regexsが設定されていること" do
    @question.owner_regexs.length.should == 2
  end
end
