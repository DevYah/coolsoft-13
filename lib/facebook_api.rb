class FacebookApi
  class IdeaHooks
    include Rails.application.routes.url_helpers

    def after_save(idea)

      graph = Koala::Facebook::API.new(idea.user.authentication_token)
      Thread.new {
        graph.put_connections("me", "idearator:create", idea: "http://idearator.pagekite.me/ideas/#{idea.id}")
      }
    end
  end

  class VoteHooks
    include Rails.application.routes.url_helpers

    def after_save(vote)
      graph = Koala::Facebook::API.new(vote.idea.user.authentication_token)
      Thread.new {
        graph.put_connections("me", "idearator:vote", idea: "http://idearator.pagekite.me/ideas/#{vote.idea.id}")
      }
    end
  end
end
