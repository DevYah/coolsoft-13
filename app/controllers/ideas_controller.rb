class IdeasController < ApplicationController
	# Archives/Unarchives a specific idea
	# Params:
	# +id+:: is used to specify the instance of +Idea+ to be archived
	# Author: Mahmoud Abdelghany Hashish
	def archiveAndUnarchive
		@idea = Idea.find(params[:id])

		if current_user.isAdmin || current_user.id == @idea.user_id
			@idea.archived = !@idea.archived
    		
    		respond_to do |format|
      			format.html { redirect_to '/', alert: 'Idea has been successfully archived.' }
      			format.json { head :no_content }
    		end
    	else
    		respond_to do |format|
      			format.html { redirect_to @idea, alert: "Idea isn't archived, you are not allowed to archive it." }
      			format.json { head :no_content }
    		end
    	end
    end 		
end