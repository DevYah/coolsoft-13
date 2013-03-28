class HomeController < ApplicationController
	#index method is the method used to display the idea stream, top ten and trending ideas.
	#Author: Hesham Nabil
	# Method gets all ideas, order them in descending order according to number of votes 
	# and sends maximum ten ideas to index view page
	# Author: Lina Basheer
	def index
		@approved = Idea.find(:all, :conditions => { :approved => true })
		@top= Idea.find(:all,:order=> "num_votes",:limit=>10).reverse
        render :action => 'index.html.erb'
	end
		
	def show
		@ideas = Idea.all
		@search = Idea.search do
			fulltext params[:search]
		end
		@ideas = @search.results
		if @ideas.size == 0
			flash[:alert] = "NO match"
		end
	 end
	 
end
