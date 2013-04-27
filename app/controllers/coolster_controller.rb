class CoolsterController

  def add_online_user
    Coolster.add_to_online_users(params[:user])
  end

end