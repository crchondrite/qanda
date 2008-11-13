require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestionsController do
  describe "route generation" do
    it "should map #index(root_url)" do
      route_for(:controller => "questions", :action => "index").should == "/"
    end
  
    it "should map #new" do
      route_for(:controller => "questions", :action => "new").should == "/questions/new"
    end
  
    it "should map #show" do
      route_for(:controller => "questions", :action => "show", :id => 1).should == "/questions/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "questions", :action => "edit", :id => 1).should == "/questions/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "questions", :action => "update", :id => 1).should == "/questions/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "questions", :action => "destroy", :id => 1).should == "/questions/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/questions").should == {:controller => "questions", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/questions/new").should == {:controller => "questions", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/questions").should == {:controller => "questions", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/questions/1").should == {:controller => "questions", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/questions/1/edit").should == {:controller => "questions", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/questions/1").should == {:controller => "questions", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/questions/1").should == {:controller => "questions", :action => "destroy", :id => "1"}
    end
  end
end
