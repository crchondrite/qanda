require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/answers/index.html.erb" do
  include AnswersHelper
  
  before(:each) do
    assigns[:answers] = [
      stub_model(Answer,
        :content => "value for content"
      ),
      stub_model(Answer,
        :content => "value for content"
      )
    ]
  end

#   it "should render list of answers" do
#     render "/answers/index.html.erb"
#     response.should have_tag("tr>td", "value for content", 2)
#   end
end

