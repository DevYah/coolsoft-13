class HomeController < ApplicationController


	#index method is the method used to display the idea stream, top ten and trending ideas.
	#Author: Hesham Nabil
	# Method gets all ideas, order them in descending order according to number of votes 
	# and sends maximum ten ideas to index view page
	# Author: Lina Basheer
	#in the index method if there is a search to be done then 
	#it will return the list containing the search results.
	#Author:Mohamed Salah Nazir
	def index
		@all = Idea.find(:all, :conditions => {:approved => true})
		@approved = Idea.find(:all, :conditions => { :approved => true })
		@top = Idea.find(:all,:order=> "num_votes",:limit=>10).reverse
        @search = Idea.search do
			fulltext params[:search]
		end
		@approved = @search.results
	end
end
		
	
	# Method gets all ideas, order them in descending order according to number of votes 
	# and sends maximum ten ideas to index view page
	# Author: Lina Basheer 

