require 'spec_helper'

describe "ideas/show.html.erb" do
	before :each do
		@idea= Idea.new
		@idea.title= "idea1"
		@idea.description= "blablabla"
		@idea.problem_solved= "ay nila"
		@idea.save
	end
	it "has a share button" do
		render :template => "/ideas/show", :locals => {:idea => @idea}
		rendered.should have_button ('Share')
	end
end