class FacebookApiCreate
  include Rails.application.routes.url_helpers

  def after_create(idea)
    if idea.user.provider == "facebook" && idea.user.facebook_share
      graph = Koala::Facebook::API.new(idea.user.authentication_token)
      Thread.new {
        graph.put_connections("me", "idearator:create", idea: "http://idearator.pagekite.me/ideas/#{idea.id}")
      }
    end
  end
end
