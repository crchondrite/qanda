require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe QuestionsController do

  def mock_question(stubs={})
    @mock_question ||= mock_model(Question, stubs)
  end

  describe "responding to GET index" do

    it "should expose all questions as @questions" do
      Question.should_receive(:find).with(:all).and_return([mock_question])
      get :index
      assigns[:questions].should == [mock_question]
    end

    describe "with mime type of xml" do
      it "should render all questions as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Question.should_receive(:find).with(:all).and_return(questions = mock("Array of Questions"))
        questions.should_receive(:to_xml).and_return("generated XML")
        get :index
        response.body.should == "generated XML"
      end
    end
  end

  describe "responding to GET show" do
    it "should expose the requested question as @question" do
      Question.should_receive(:find).with("37").and_return(mock_question)
      get :show, :id => "37"
      assigns[:question].should equal(mock_question)
    end

    describe "with mime type of xml" do
      it "should render the requested question as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Question.should_receive(:find).with("37").and_return(mock_question)
        mock_question.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end
    end
  end

  describe "responding to GET new" do
    it "should expose a new question as @question" do
      Question.should_receive(:new).and_return(mock_question)
      get :new
      assigns[:question].should equal(mock_question)
    end
  end

  describe "responding to GET edit" do
    describe "解答が一つもない場合" do 
      it "should expose the requested question as @question" do
        Question.should_receive(:find).with("37").and_return(mock_question)
        mock_question.stub!(:answers).and_return([])
        get :edit, :id => "37"
        assigns[:question].should equal(mock_question)
      end
    end
    describe "解答が存在する場合" do
      before do
        Question.should_receive(:find).with("37").and_return(mock_question)
        mock_question.stub!(:answers).and_return([mock('mock')])
        get :edit, :id => "37"
      end
      it "リダイレクトされる" do
        response.should redirect_to(question_url(mock_question))
      end
      it "flashにメッセージが設定される" do
        flash[:error] = "Question was not edit because it has answers."
      end
    end
  end

  describe "responding to POST create" do
    before do
      session[:identity_url] = "http://test.openid.com/id"
    end

    describe "with valid params" do
      it "should expose a newly created question as @question" do
        Question.should_receive(:new).with({'these' => 'params', "identity_url" => session[:identity_url]}).and_return(mock_question(:save => true))
        post :create, :question => {:these => 'params'}
        assigns(:question).should equal(mock_question)
      end

      it "should redirect to the created question" do
        Question.stub!(:new).and_return(mock_question(:save => true))
        post :create, :question => {}
        response.should redirect_to(question_url(mock_question))
      end
    end
    describe "with invalid params" do
      it "should expose a newly created but unsaved question as @question" do
        Question.stub!(:new).with({'these' => 'params', "identity_url" => session[:identity_url]}).and_return(mock_question(:save => false))
        post :create, :question => {:these => 'params'}
        assigns(:question).should equal(mock_question)
      end

      it "should re-render the 'new' template" do
        Question.stub!(:new).and_return(mock_question(:save => false))
        post :create, :question => {}
        response.should render_template('new')
      end
    end
  end

  describe "responding to PUT udpate" do
    describe "with valid params" do
      it "should update the requested question" do
        Question.should_receive(:find).with("37").and_return(mock_question)
        mock_question.stub!(:answers).and_return([])
        mock_question.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :question => {:these => 'params'}
      end

      it "should expose the requested question as @question" do
        Question.stub!(:find).and_return(mock_question(:update_attributes => true))
        mock_question.stub!(:answers).and_return([])
        put :update, :id => "1"
        assigns(:question).should equal(mock_question)
      end

      it "should redirect to the question" do
        Question.stub!(:find).and_return(mock_question(:update_attributes => true))
        mock_question.stub!(:answers).and_return([])
        put :update, :id => "1"
        response.should redirect_to(question_url(mock_question))
      end
    end
    describe "with invalid params" do
      it "should update the requested question" do
        Question.should_receive(:find).with("37").and_return(mock_question)
        mock_question.should_receive(:update_attributes).with({'these' => 'params'})
        mock_question.stub!(:answers).and_return([])
        put :update, :id => "37", :question => {:these => 'params'}
      end

      it "should expose the question as @question" do
        Question.stub!(:find).and_return(mock_question(:update_attributes => false))
        mock_question.stub!(:answers).and_return([])
        put :update, :id => "1"
        assigns(:question).should equal(mock_question)
      end

      it "should re-render the 'edit' template" do
        Question.stub!(:find).and_return(mock_question(:update_attributes => false))
        mock_question.stub!(:answers).and_return([])
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
  end

  describe "responding to DELETE destroy" do
    it "should destroy the requested question" do
      Question.should_receive(:find).with("37").and_return(mock_question)
      mock_question.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "should redirect to the questions list" do
      Question.stub!(:find).and_return(mock_question(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(questions_url)
    end
  end
end
