require 'spec_helper'
describe StreamController do
  describe 'Get #index' do
    it 'populates two ideas matching the search' do
      idea = Idea.new
      idea.title = "title"
      idea.problem_solved = "problem"
      idea.description = "description"
      idea.save
      #Idea.should_receive(:search).with('ti')
      get :index, :search => 'ti', :tag => [], :mypage => 1, :search_user => 'false', :searchtype => 'false', :insert => 'true', :set_global => 'false', :reset_global => 'true'
    end
  end
end