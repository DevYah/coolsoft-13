require 'rest_client'

class Coolster

  @@online_users = [1, 3]

  def self.add_to_online_users(user)
    unless @@online_users.include?(user)
      @@online_users << user
    end
  end

  def self.update_all (script)
    RestClient.post 'http://localhost:3000/coolster_app/push_to_all', {script: script, multipart: true}
  end

  def self.update (user_ids, script)
    scripts = {}
    users = @@online_users & user_ids
    RestClient.post 'http://localhost:3000/coolster_app/push', {script: script, users: users, multipart: true}
  end

  def self.update_each (user_ids, &block)
    scripts = {}
    users = @@online_users & user_ids
    case block.arity
      when 0
        script = yield
        users.each do |user|
          scripts[user] = script
        end
      when 1
        users.each do |user|
          script = yield user
          scripts[user] = script
        end
      else
        raise Exception
    end
    RestClient.post 'http://localhost:3000/coolster_app/push_to_each', {scripts: scripts, multipart: true}
  end

end