class HomeController < ApplicationController
  #Used to display the idea stream, top ten and trending ideas.
  #Author: Hesham Nabil
  #Calls the action index but with the search parameters filtering
  #the @approved to the ideas matching this search
  #Author: Mohamed Salah Nazir
  def index
    @approved = Idea.find(:all, :conditions => { :approved => true })
    @user = current_user
    @top = Idea.find(:all, :order => 'num_votes', :limit => 10).reverse
    @approved = Idea.search(params[:search])
    @all = Idea.find(:all, :conditions => { :approved => true })
    @top = Idea.find(:all, :order => 'num_votes', :limit => 10).reverse
    respond_to do |format|
        format.html
        format.js
    end
  end
end

