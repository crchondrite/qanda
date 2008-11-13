require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Answer do
  before(:each) do
    @valid_attributes = {
      :content => "value for content",
      :identity_url => "value for identity_url"
    }
  end

  it "should create a new instance given valid attributes" do
    Answer.create!(@valid_attributes)
  end
end

describe Answer, "#set_content" do
  before do
    @answer = Answer.new
  end
  describe "paramsに消すべき要素が入っている場合" do 
    before do
      @params = { "commit" => "Commit" }
    end
    it "contentに消すべき要素は含まれないこと" do
      @answer.set_content(@params)
      @answer.content.should_not be_include(@params.keys.first)
    end
  end
  describe "paramsに消すべきでない要素が入っている場合" do
    before do
      @params = { "hoge" => "hoge" }
    end
    it "contentに要素が含まれること" do
      @answer.set_content(@params)
      @answer.content.should be_include(@params.keys.first)
    end
  end
end
