class HomeController < ApplicationController
	
	def index
		@approved = Idea.find(:all, :conditions => { :approved => true })
	end
		
end
