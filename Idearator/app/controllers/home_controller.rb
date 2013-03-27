class HomeController < ApplicationController
	def index 
		@ideas = Idea.all
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
