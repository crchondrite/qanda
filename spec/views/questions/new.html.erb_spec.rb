require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/new.html.erb" do
  include QuestionsHelper
  
  before(:each) do
    assigns[:question] = stub_model(Question,
      :new_record? => true,
      :content => "value for content"
    )
  end

  it "should render new form" do
    render "/questions/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", questions_path) do
      with_tag("textarea#question_content[name=?]", "question[content]")
    end
  end
end


