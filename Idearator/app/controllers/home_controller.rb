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
      format.html
    end 
  end
  #Calls the action search but with the search parameters filtering
  #the ideas matching this search
  #params:
  #+search+::the parameter is the search written by the user 
  #Author: Mohamed Salah Nazir
  def search
    if params[:search].length > 0
      @search = Idea.search(params[:search])
      respond_to do |format|
        format.html
        format.js
      end
    else
      index
    end
  end
end