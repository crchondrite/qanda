require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/questions/edit.html.erb" do
  include QuestionsHelper
  
  before(:each) do
    assigns[:question] = @question = stub_model(Question,
      :new_record? => false,
      :content => "value for content"
    )
  end

  it "should render edit form" do
    render "/questions/edit.html.erb"
    
    response.should have_tag("form[action=#{question_path(@question)}][method=post]") do
      with_tag('textarea#question_content[name=?]', "question[content]")
    end
  end
end


