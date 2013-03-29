class HomeController < ApplicationController
	#Used to display the idea stream, top ten and trending ideas.
	#Author: Hesham Nabil
	def index
		@approved = Idea.find(:all, :conditions => { :approved => true })
	end
	 
end
