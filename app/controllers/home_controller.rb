class HomeController < ApplicationController
	# Method gets all ideas, order them in descending order according to number of votes 
	# and sends top ten ideas to index view page
	# Author: Lina Basheer 
	def index
@top= Idea.find(:all,:order=> "num_votes",:limit=>10).reverse
render :action => 'index.html.erb'
    end
end

