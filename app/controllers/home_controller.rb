class HomeController < ApplicationController
	#index method is the method used to display the idea stream, top ten and trending ideas.
	#@approved is the list of all the approved ideas according to the flag "approved"
	def index
		@approved = Idea.find(:all, :conditions => { :approved => true })

		@top= Idea.find(:all,:order=> "num_votes",:limit=>10).reverse
        render :action => 'index.html.erb'
	end
		
end
