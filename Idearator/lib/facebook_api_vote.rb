class FacebookApiVote
  include Rails.application.routes.url_helpers

  def after_save(vote)
    if vote.idea.user.provider == "facebook" && vote.idea.user.facebook_share
      graph = Koala::Facebook::API.new(vote.idea.user.authentication_token)
      Thread.new {
        graph.put_connections("me", "idearator:vote", idea: "http://idearator.pagekite.me/ideas/#{vote.idea.id}")
      }
    end
  end
end
