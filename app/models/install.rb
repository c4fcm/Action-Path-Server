class Install < ActiveRecord::Base

  has_many :responses

  def self.get_or_create device_id
    matching = Install.where(:device_id=>device_id).count
    if matching==0
      found = Install.create(:device_id=>device_id) # this saves it too
    else
      found = Install.where(:device_id=>device_id).first
    end
    found
  end
  
end
