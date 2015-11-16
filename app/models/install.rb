class Install < ActiveRecord::Base

  has_many :responses
  has_many :logs

  def self.get_or_create device_id
    matching = Install.where(:device_id=>device_id).count
    if matching==0
      found = Install.create(:device_id=>device_id) # this saves it too
    else
      found = Install.where(:device_id=>device_id).first
    end
    found
  end

  def geofence_click_rate
    Log.geofence_click_rate @device_id
  end

  def geofence_response_rate
    Log.geofence_response_rate @device_id
  end

end
