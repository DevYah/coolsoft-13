class HomeController < ApplicationController
	#Used to display the idea stream, top ten and trending ideas.
	#returns a list of ideas ordered by the date of creation in pages 
	#of 10 ideas.
	#Params:
	#+page+:: the parameter is the page user is currently browsing.
	#Author: Hesham Nabil
	def index
		@approved = Idea.order(:created_at).page(params[:page]).per(10)
        @top= Idea.find(:all,:order=> "num_votes DESC",:limit=>10)
        
        respond_to do |format|
   		 	format.js
    		format.html # index.html.erb
    		format.xml  { render :xml => @approved }
    	end	
    end

end

