# Author: Mina Nagy
# disable bot-away for login forms because these are usually filled in by
# browsers
BotAway.disabled_for :controller => 'sessions', :action => 'new'
BotAway.disabled_for :controller => 'sessions', :action => 'create'
# disable bot-away in development
BotAway.disabled_for :mode => 'development'

# FIXME
# disable bot-away in production temporarily until proper exceptions are added
BotAway.disabled_for :mode => 'production'

# show honeypots for debugging purposes
#BotAway.show_honeypots = true
# disable bot-away for certain javascript generated params
# this should be done for idea perspective params for example
# FIXME important!
#BotAway.accepts_unfiltered_params "user"
