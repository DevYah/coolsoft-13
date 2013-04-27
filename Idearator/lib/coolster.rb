require 'rest_client'

class Coolster

  @@online_users = []

  def self.send_update(script)
    RestClient.post 'http://localhost:9292/update', {script: script, multipart: true}
  end

  def self.add_to_online_users(user)
    @@online_users << user
  end

  def self.send_update_for_users(users, script = nil, &block)
    users = @@online_users & users
    scripts = {}
    if script.nil?
      unless block.nil?
        if block.arity == 1
          users.each do |user|
            script = yield user
            scripts[user.id] = script
          end
        else
          script = yield
          users.each do |user|
            scripts[user.id] = script
          end
        end
      end
    else
      users.each do |user|
        scripts[user.id] = script
      end
    end
    RestClient.post 'http://localhost:9292/update', {scripts: scripts, multipart: true}
  end

end

