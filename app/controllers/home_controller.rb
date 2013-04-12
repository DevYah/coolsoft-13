class HomeController < ApplicationController
  #Used to display the idea stream, top ten and trending ideas.
  #Author: Hesham Nabil
  #Calls the action index but with the search parameters filtering
  #the @approved to the ideas matching this search
  #Author: Mohamed Salah Nazir
  def index
        @approved = Idea.order(:created_at).page(params[:page]).per(10)
        @top= Idea.find(:all,:order=> "num_votes DESC",:limit=>10)
        
        respond_to do |format|
        format.js
        format.html # index.html.erb
        #format.xml  { render :xml => @approved }
      end 
    end

  def search
    if params[:search].length > 0
      @search = Idea.search(params[:search])
      respond_to do |format|
        format.html
        format.js
      end
    else
        #@approved = Idea.order(:created_at).page(1).per(10)
        #@top= Idea.find(:all,:order=> "num_votes DESC",:limit=>10)
        #respond_to do |format|
         #format.html
         #format.js
        #end
        index
    end

  end
end