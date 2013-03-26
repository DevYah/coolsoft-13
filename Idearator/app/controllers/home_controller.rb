class HomeController < ApplicationController
	def show
		@search = Idea.search do 
		fulltext params[:search]
		end
		@ideas = @search.results
	end
end
