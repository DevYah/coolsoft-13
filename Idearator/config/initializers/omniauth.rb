OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '446451938769749', '7e67a1173177a17d9774812138092a8f', :scope => 'publish_actions'
  provider :twitter, 'lwriQjeyfOMojlldOQbiZQ', 'GD9olZVUib7uSpqXEut1bczCbpltsu5x7a6FfazcOE'
end
