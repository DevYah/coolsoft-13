class IdeasController < ApplicationController
def show
  current_user = User.find(1)
    @user=current_user.id
      @idea = Idea.find(params[:id])
      respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea }
       end
     end
	def new
          @idea=Idea.new
          @tags= Tag.all
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
    #puts params

    @idea = Idea.new(params[:idea])
    

    # @idea.user_id=current_user.id
    respond_to do |format|
      if @idea.save
        @tags= params[:idea_tags][:tags]
        @tags.each do |tag|
          IdeasTag.create(:idea_id => @idea.id , :tag_id => tag)
        end
        format.html { redirect_to @idea, notice: 'idea was successfully created.' }
        format.json { render json: @idea, status: :created, location: @idea }
      else
        format.html { render action: "new" }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end
end
