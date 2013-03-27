class HomesController < ApplicationController
	
	def index
@top= Idea.find(:all,:order=> "num_votes",:limit=>10).reverse
render :action => 'index.html.erb'
    end

end

