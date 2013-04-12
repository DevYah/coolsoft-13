class HomeController < ApplicationController

	#Used to display the idea stream, top ten and trending ideas.
	#Author: Hesham Nabil

	def index
		@approved = Idea.find(:all, :conditions => { :approved => true })
		@user = current_user
        @top= Idea.find(:all,:order=> "num_votes",:limit=>10).reverse
        render :action => 'index.html.erb'
    end

end

