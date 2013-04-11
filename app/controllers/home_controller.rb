class HomeController < ApplicationController
<<<<<<< HEAD
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
=======
  #Used to display the idea stream, top ten and trending ideas.
  #Author: Hesham Nabil
  #Calls the action index but with the search parameters filtering
  #the @approved to the ideas matching this search
  #Author: Mohamed Salah Nazir
  def index
    @approved = Idea.find(:all, :conditions => { :approved => true })
    @user = current_user
    @top = Idea.find(:all, :order => 'num_votes', :limit => 10).reverse
    respond_to do |format|
        format.html
        format.js
>>>>>>> C4_LinaBasheer_#92_Graph
    end
  end
end
