class Place < ActiveRecord::Base
  has_many :issues

  PROVIDER_SEE_CLICK_FIX = "seeclickfix"
  PROVIDER_CUSTOM = "custom"

  def self.providers
    [PROVIDER_SEE_CLICK_FIX, PROVIDER_CUSTOM]
  end

  def self.from_json json
    p = Place.new
    p.id = json['id']
    p.name = json['name']
    p.json = json
    p.url_name = json['url_name']
    p.state = json['state']
    p
  end

end
