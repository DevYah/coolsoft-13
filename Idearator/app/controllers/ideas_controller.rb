class IdeasController < ApplicationController
	# Deletes all records related to a specific idea
	# Params:
	# +id+:: is used to specify which instance of +Idea+ will be deleted
	# Author: Mahmoud Abdelghany Hashish
	def destroy
		@idea = Idea.find(params[:id])

		if current_user.id == @idea.user_id
			@idea.destroy

			respond_to do |format|
      			format.html { redirect_to '/' }
      			format.json { head :no_content }
    		end
    	else
    		respond_to do |format|
      			format.html { redirect_to @idea }
      			format.json { head :no_content }
    		end
    	end
    end
end