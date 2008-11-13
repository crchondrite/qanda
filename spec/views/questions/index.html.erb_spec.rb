require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/index.html.erb" do
  include QuestionsHelper
  
  before(:each) do
    assigns[:questions] = [
      stub_model(Question,
        :content => "value for content"
      ),
      stub_model(Question,
        :content => "value for content"
      )
    ]
  end

  it "should render list of questions" do
    render "/questions/index.html.erb"
    response.should have_tag("tr>td", "value for content", 2)
  end
end

