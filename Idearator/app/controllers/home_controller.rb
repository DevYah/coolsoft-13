class HomeController < ApplicationController

	#Used to display the idea stream, top ten and trending ideas.
	#Author: Hesham Nabil
	# Method gets all ideas, order them in descending order according to number of votes 
	# and sends maximum ten ideas to index view page
	# Author: Lina Basheer
	#in the index method if there is a search to be done then 
	#it will return the list containing the search results.
	#Author:Mohamed Salah Nazir
	
	def index
		@user = current_user
		@all = Idea.find(:all, :conditions => {:approved => true})
		@approved = Idea.find(:all, :conditions => { :approved => true })
		@top= Idea.find(:all, :conditions => { :approved => true },:order=> "num_votes desc",:limit=>10)
        @search = Idea.search do
			fulltext params[:search]
		end
		@approved = @search.results
	end
end
