class HomeController < ApplicationController
	def index 
		@ideas = Idea.all
	end
	def show
		@ispresent  = 1
		@ideas = Idea.all
		@search = Idea.search do
			fulltext params[:search]
		end
		@ideas = @search.results
 end
end
