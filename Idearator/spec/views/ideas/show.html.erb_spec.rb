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

  it "has a pinterest image" do
    render :template => "/ideas/show", :locals => {:idea => @idea}
    response.should have_tag("img", :id => "pin")

  it "has a facebook image" do
    render :template => "/ideas/show", :locals => {:idea => @idea}
    response.should have_tag("img", :id => "fbk")
  end
  it "has a twitter image" do
    render :template => "/ideas/show", :locals => {:idea => @idea}
    response.should have_tag("img", :id => "tw")
  end
end