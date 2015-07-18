class EventIsopt < ActiveRecord::Base
  
  has_many :user_devices
  has_many :users, :through => :user_devices, :source => :user
  has_many :devices, :through => :user_devices, :source => :device

  def conv_to_json
    json = {
      id: self.id,
      held_at: self.held_at.try("strftime", "%Y/%m/%d"),
      venue_name: self.venue_name,
      title: self.title,
      tz_offset: self.tz_offset
    }

    
    json[:users] = []

    self.users.each do |user|
      user_json = {
        personal_time: user.personal_time,
        fullname: user.fullname
      }

      json[:users] << user_json
    end

    json
  end

  def tz_offset_in_hour
    self.tz_offset.gsub("0", "").to_i.hour
  end

  def consensus_time
    
  end

  def self.no_other_event_running?
    EventIsopt.where(is_activated: true, is_ended: false).count == 0
  end

  def reset_all_records!
    self.users.each do |user|
      user.init_time = nil
      user.is_initialized = false
      user.init_at = nil
      user.save 

      user.moment_records.destroy_all
    end

  end


end
