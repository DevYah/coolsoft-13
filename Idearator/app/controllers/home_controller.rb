class HomeController < ApplicationController
	# Method gets all ideas, order them in descending order according to number of votes 
	# and sends top ten ideas to index view page
	# Author: Lina Basheer 
	def index
      @top= Idea.find(:all, :conditions => { :approved => true },:order=> "num_votes desc",:limit=>10)
      render :action => 'index.html.erb'
    end
end

