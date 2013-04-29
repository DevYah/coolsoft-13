require 'rest_client'

class Coolster

  @@online_user_ids = []

  def self.add_to_online_users(user_id)
    unless @@online_user_ids.include?(user_id)
      @@online_user_ids << user_id
    end
  end

  def self.update_all(script)
    RestClient.post app.root_url + '/coolster_app/push_to_all', {script: script, multipart: true}
  end

  def self.update(user_ids, script)
    scripts = {}
    user_ids = @@online_user_ids & user_ids
    RestClient.post app.root_url + '/coolster_app/push', {script: script, users: user_ids, multipart: true}
  end

  def self.update_each(user_ids, &block)
    scripts = {}
    user_ids = @@online_user_ids & user_ids
    case block.arity
      when 0
        script = yield
        user_ids.each do |user_id|
          scripts[user_id] = script
        end
      when 1
        user_ids.each do |user_id|
          script = yield user_id
          scripts[user_id] = script
        end
      else
        raise Exception
    end
    RestClient.post app.root_url + '/coolster_app/push_to_each', {scripts: scripts, multipart: true}
  end

end