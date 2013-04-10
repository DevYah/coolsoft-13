require 'spec_helper'

describe HomeController do
  describe 'GET #index' do
    it 'populates 1 idea' do
    	idea = Idea.new
    	idea.title = "idea1"
    	idea.description = "idea"
    	idea.problem_solved = "problem"
    	idea.save
    get :index, :search => "idea1"
    assigns(:approved).size.should eq(1)
    end
    it 'populates 0 ideas' do
    	idea = Idea.new
    	idea.title = "idea1"
    	idea.description = "idea"
    	idea.problem_solved = "problem"
    	idea.save
      get :index, :search => "idea23"
    assigns(:approved).size.should eq(0)	
    end
  end
end