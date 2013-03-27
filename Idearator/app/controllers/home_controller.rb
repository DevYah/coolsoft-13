class HomeController < ApplicationController
	
	def index
		@approved = Idea.find(:all, :conditions => { :approved => true })

		@top= Idea.find(:all,:order=> "num_votes",:limit=>10).reverse
        render :action => 'index.html.erb'
	end
		
end
