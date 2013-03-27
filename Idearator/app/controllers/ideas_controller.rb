class IdeasController < ApplicationController
	
	def new
		@idea = Idea.new
	end
		
	def create 
		@idea = Idea.new(params[:idea])
		@idea.update_attributes(:num_votes => 0) 
		if @idea.save
            redirect_to root_url, notice: "Your Idea has been created!"
        end    
	end

end
