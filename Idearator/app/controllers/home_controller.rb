class HomeController < ApplicationController
	#Used to display the idea stream, top ten and trending ideas.
	#returns a list of ideas ordered by the date of creation in pages 
	#of 10 ideas.
	#Params:
	#+page+:: the parameter is the page user is currently browsing.
	#Author: Hesham Nabil ,Muhammed Hassan
	def index
    if(params[:myTags])
      if(params[:myTags].length>0)
      tags = Array(params[:myTags])
      tags.map! { |e| e.delete(' ') }
      @approved = Idea.joins(:tags).where(:tags => {:name => tags}).page(params[:myPage].to_i).per(10)
      else
        @approved = Idea.order(:created_at).page(params[:myPage]).per(10)
      end
    else
        @approved = Idea.order(:created_at).page(params[:myPage]).per(10) 
    end
        respond_to do |format|
          format.js
          format.html # index.html.erb
          format.xml  { render :xml => @approved }
        end
  end 
    
  def test
  end
end

