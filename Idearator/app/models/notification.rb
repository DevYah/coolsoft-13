class Notification < ActiveRecord::Base
  acts_as_superclass
  

  has_many :notifications_users, :dependent => :destroy
  has_many :users, :through => :notifications_users
  attr_accessible :users, :created_at

  def self.getDay_of_week(day)
    day_in_week = ""
    if day == 0
      day_in_week="Sunday"
    else
      if day == 1
        day_in_week = "Monday"
      else
        if day == 2
          day_in_week = "Tuesday"
        else
          if day == 3
            day_in_week = "Wednesday"
          else
            if day == 4
              day_in_week = "Thursday"
            else
              day_in_week = "Friday"
            end
          end
        end
      end
    end
  end

  def self.getDate(not_id)
    notif_time = Notification.find(not_id).created_at
    notif_date = Notification.find(not_id).created_at.to_date
    curr_date = Time.now.to_date
    date = ""
    
      if notif_date.month == curr_date.month and notif_date.year == curr_date.year
        if curr_date.day - notif_date.day < 7
          if curr_date.day - notif_date.day == 1
            date = "Yesterday" + " at, " + notif_time.strftime("%H:%M")
          else
            date = Idea.getDay_of_week(notif_date.day) + " at, " + notif_time.strftime("%H:%M")
          end
        else
          date = Idea.getDay_of_week(notif_date.day) + notif_date.day.to_s + " at, " + notif_time.strftime("%H:%M")
        end
      else
        if notif_date.month != curr_date.month and notif_date.year == curr_date.year
          date = Date::MONTHNAMES[Date.today.month] + " "+ Idea.getDay_of_week(notif_date.day)
        else
          date = Date::MONTHNAMES[Date.today.month] + ", " + Idea.getDay_of_week(notif_date.day) + notif_date.year.to_s
        end
      end
    
  end

end