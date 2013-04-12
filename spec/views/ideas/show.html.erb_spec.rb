require 'spec_helper'

describe "ideas/show.html.erb" do
	before :each do
		@idea= Idea.new
		@idea.title= "idea"
		@idea.description= "idea"
		@idea.problem_solved= "idea"
		@idea.save
	end
	it "has a share button" do
		render :template => "/ideas/show", :locals => {:idea => @idea}
		rendered.should have_button ('Share')
	end

	it "has a pinterest image" do
		render :template => "/ideas/show", :locals => {:idea => @idea}
		response.should have_tag("img", :id => "pin")
	end 
end