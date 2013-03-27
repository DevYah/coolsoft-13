class UsersController < ApplicationController

	def confirm_deactivate
		@user = current_user
	end

end
