class FacebookApiVote

  def after_create(vote)
    if vote.user.provider == "facebook" && vote.user.facebook_share
      graph = Koala::Facebook::API.new(vote.user.authentication_token)
      Thread.new {
        graph.put_connections("me", "idearator:vote", idea: "http://idearator.pagekite.me/ideas/#{vote.idea.id}")
      }
    end
  end
end
