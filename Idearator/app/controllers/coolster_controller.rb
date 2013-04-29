class CoolsterController < ApplicationController

  def add_online_user
    Coolster.add_to_online_users(params[:user])
    render text: "ok"
  end

end
