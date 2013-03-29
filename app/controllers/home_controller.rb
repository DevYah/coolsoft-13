class HomeController < ApplicationController
	#index method is the method used to display the idea stream, top ten and trending ideas.
	#Author: Hesham Nabil
	def index
		@approved = Idea.find(:all, :conditions => { :approved => true })
	end
	 
end
