class HomeController < ApplicationController
	#Used to display the idea stream, top ten and trending ideas.
	#Author: Hesham Nabil
	def index
		@approved = Idea.order(:created_at).page(params[:page]).per(10)
		@user = current_user
        @top= Idea.find(:all,:order=> "num_votes DESC",:limit=>10)
        
        respond_to do |format|
   		 	format.js
    		format.html # index.html.erb
    		format.xml  { render :xml => @approved }
    	end	
    end

end

