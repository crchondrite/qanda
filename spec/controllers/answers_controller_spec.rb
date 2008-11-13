require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AnswersController do
  def mock_answer(stubs={})
    @mock_answer ||= mock_model(Answer, stubs)
  end

  def mock_question(stubs={})
    @mock_question ||= mock_model(Question, stubs)
  end

  before do
    session[:identity_url] = "http://test.openid.com/id"
  end
  describe "responding to GET index" do
    it "should expose all answers as @answers" do
      Question.should_receive(:find).with("37").and_return(mock_question)
      mock_question.should_receive(:answers).and_return([mock_answer])
      get :index, :question_id => 37
      assigns[:answers].should == [mock_answer]
    end

    describe "with mime type of xml" do

      it "should render all answers as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Question.should_receive(:find).with("37").and_return(mock_question)
        mock_question.should_receive(:answers).and_return(answers = mock("Array of Answers"))
        answers.should_receive(:to_xml).and_return("generated XML")
        get :index, :question_id => 37
        response.body.should == "generated XML"
      end
    end
  end

  describe "responding to GET show" do
    it "should expose the requested answer as @answer" do
      Answer.should_receive(:find).with("37").and_return(mock_answer)
      get :show, :id => "37"
      assigns[:answer].should equal(mock_answer)
    end

    describe "with mime type of xml" do

      it "should render the requested answer as xml" do
        request.env["HTTP_ACCEPT"] = "application/xml"
        Answer.should_receive(:find).with("37").and_return(mock_answer)
        mock_answer.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37"
        response.body.should == "generated XML"
      end
    end
  end

  describe "responding to GET new" do
    before do
      Question.should_receive(:find).and_return(mock_question)
    end
    it "should expose a new answer as @answer" do
      Answer.should_receive(:new).and_return(mock_answer)
      get :new
      assigns[:answer].should equal(mock_answer)
    end
  end

  describe "responding to POST create" do
    describe "with valid params" do
      it "Answerにset_contentでcontentが設定されること" do
        mock_answer(:save => true)
        mock_answer.should_receive(:set_content)
        Answer.should_receive(:new).with({:question_id => "1", :identity_url => session[:identity_url]}).and_return(mock_answer)

        post :create, :question_id => 1, :hoge => "hoge"

        assigns(:answer).should equal(mock_answer)
      end

      it "should redirect to the created answer" do
        Answer.stub!(:new).with({:question_id => "1", :identity_url => session[:identity_url]}).and_return(mock_answer(:save => true))
        mock_answer.should_receive(:set_content)
        post :create, :question_id => 1, :answer => {}
        response.should redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "should expose a newly created but unsaved answer as @answer" do
        Answer.stub!(:new).with({:question_id => "1", :identity_url => session[:identity_url]}).and_return(mock_answer(:save => false))
        mock_answer.should_receive(:set_content)
        post :create, :answer => {:these => 'params'}, :question_id => 1
        assigns(:answer).should equal(mock_answer)
      end

      it "should re-render the 'new' template" do
        Answer.stub!(:new).with({:question_id => "1", :identity_url => session[:identity_url]}).and_return(mock_answer(:save => false))
        mock_answer.should_receive(:set_content)
        post :create, :answer => {}, :question_id => 1
        response.should render_template('new')
      end
    end
  end
end
