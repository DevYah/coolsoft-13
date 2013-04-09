require 'spec_helper'

describe HomeController do

  describe "GET index" do

    it { should paginate(Home).with_default_per_page(10) }
    
    before(:each) do
      assign(:ideas, Kaminari.paginate_array([
        Factory.stub(:post),
        Factory.stub(:post)
      ]).page(1))
    end

    it "succeeds" do
      get :index
      response.should be_success
    end

    it "returns results page" do
       Program.should_receive(:paginate).with(:page => nil, :per_page => 30) do
        [mock_program]
      end
      get :index
      response.should be_success
      assigns(:programs).should == [mock_program]
    end
    it "renders the index page" do
      get :index

      response.should render_template("home/index")
    end
  end
end