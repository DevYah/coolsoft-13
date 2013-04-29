require 'rest_client'

module Coolster

  @@online_user_ids = []

  def self.add_to_online_users(user_id)
    unless @@online_user_ids.include?(user_id)
      @@online_user_ids << user_id
    end
  end

  def self.update_all(script)
    begin
      RestClient.post 'http://localhost:9292/push_to_all', {script: script, multipart: true}
    rescue => e
    end
  end

  def self.update(user_ids, script)
    scripts = {}
    user_ids = @@online_user_ids & user_ids
    begin
      RestClient.post 'http://localhost:9292/push', {script: script, users: user_ids}
    rescue => e
    end
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
    begin
      RestClient.post 'http://localhost:9292/push_to_each', {scripts: scripts, multipart: true}
    rescue => e
    end
  end

end
