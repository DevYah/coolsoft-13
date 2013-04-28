require 'rest_client'

class Coolster

  @@online_users = []

  def self.add_to_online_users(user)
    unless @@online_users.include?(user)
      @@online_users << user
    end
  end

  def self.send_update1 (script)
    RestClient.post 'http://localhost:3000/coolster_app/update', {script: script, all: true, multipart: true}
  end

  def self.send_update2 (users, script)
    scripts = {}
    users = @@online_users & users
    users.each do |user|
      scripts[user] = script
    end
    RestClient.post 'http://localhost:3000/coolster_app/update', {scripts: scripts, all:false, multipart: true}
  end

  def self.send_update3 (users, &block)
    scripts = {}
    users = @@online_users & users
    if block.arity == 1
      users.each do |user|
        script = yield user
        scripts[user] = script
      end
    else
      script = yield
      users.each do |user|
        scripts[user] = script
      end
    end
    RestClient.post 'http://localhost:3000/coolster_app/update', {scripts: scripts, all: false, multipart: true}
  end



#   def self.send_update (script)
#     EventMachine::HttpRequest.new('http://localhost:3000/coolster_app/update').post :body => {script: script}
#   end

#   def self.send_update (script, users)
#     users = @@online_users & users
#     EventMachine::HttpRequest.new('http://localhost:3000/coolster_app/update').post :body => {script: script, users: users}
#   end

#   def self.add_to_online_users(user)
#     @@online_users << user
#   end
# ###
#   def self.send_update(users, script = nil, &block)
#     scripts = {}
#     if users.nil?
#       if script.nil?
#         script = yield
#       end
#       EventMachine::HttpRequest.new('http://localhost:3000/coolster_app/update').post :body => {script: script}
#     else
#       users = @@online_users & users
#       if script.nil?
#         unless block.nil?
#           if block.arity == 1
#             users.each do |user|
#               script = yield user
#               scripts[user.id] = script
#             end
#           else
#             script = yield
#             users.each do |user|
#               scripts[user.id] = script
#             end
#           end
#         end
#       else
#         EventMachine::HttpRequest.new('http://localhost:3000/coolster_app/update').post :body => {script: script, users: users}
#       end
#     end
#   end
# ####
#   def self.send_update(users = nil, script = nil, &block)

#     users = @@online_users & users
#     scripts = {}
#     if script.nil?
#       unless block.nil?
#         if block.arity == 1
#           users.each do |user|
#             script = yield user
#             scripts[user.id] = script
#           end
#         else
#           script = yield
#           users.each do |user|
#             scripts[user.id] = script
#           end
#         end
#       end
#     else
#       users.each do |user|
#         scripts[user.id] = script
#       end
#     end
#     RestClient.post 'http://localhost:9292/update', {scripts: scripts, multipart: true}
#   end

end

