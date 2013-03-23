class HomeController < ApplicationController
def index
	@blog = Blog.find(session[:user_id])
	rescue ActiveRecord::RecordNotFound
  end
end
