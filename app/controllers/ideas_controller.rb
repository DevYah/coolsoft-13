class IdeasController < ApplicationController
	def show
      		@idea = Idea.find(params[:id])
     		# @idea=Idea.new
     		#rescue ActiveRecord::RecordNotFound
      
      		respond_to do |format|
      			format.html # show.html.erb
      			format.json { render json: @idea }
      		end
     	end
	
	def index

	end
	
	def new
		@idea=Idea.new
		
		respond_to do |format|
	      		format.html # new.html.erb
	      		format.json { render json: @idea }
	    	end
	end
	
	def edit   
    		@idea = Idea.find(params[:id])
  	end
  	
	def update
    
    		@idea = Idea.find(params[:id])
    
		respond_to do |format|
      			if @idea.update_attributes(params[:idea])
        			format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        			format.json { head :no_content }
      			else
        			format.html { render action: "edit" }
        			format.json { render json: @idea.errors, status: :unprocessable_entity }
      			end
    		end
  	end
	
	def create
    		@idea = Idea.new(params[:idea])
     
    		respond_to do |format|
      			if @idea.save
        			format.html { redirect_to @idea, notice: 'idea was successfully created.' }
        			format.json { render json: @idea, status: :created, location: @idea }
      			else
        			format.html { render action: "new" }
        			format.json { render json: @idea.errors, status: :unprocessable_entity }
      			end
   		end
  	end

	def destroy
		@current_user = User.first
    		@idea = Idea.find(params[:id])
		puts "DEBUG: " + @current_user.id.to_s + " " + @idea.user_id.to_s
		if @current_user.id == @idea.user_id    
			puts "authed!"		
			@idea.destroy
    			
    			respond_to do |format|
    				format.html { redirect_to '/' }
      				format.json { head :no_content }
    			end
		else
			respond_to do |format|
    				format.html { redirect_to @idea }
      				format.json { notice 'idea cannot be deleted' }
    			end
		end
  	end
end

