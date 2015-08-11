class Issue < ActiveRecord::Base
  has_many :subscriptions
  belongs_to :place

  def self.from_json json
    i = Issue.new
    i.id = json['id']
    i.status = json['status']
    i.summary = json['summary']
    i.description = json['description']
    i.lat = json['lat']
    i.lng = json['lng']
    i.address = json['address']
    i.image_full = json['media']['image_full']
    i.created_at = Time.parse(json['created_at']).in_time_zone
    i.updated_at = Time.parse(json['updated_at']).in_time_zone
    i
  end

  def scf_url
    "http://seeclickfix.com/issues/#{id}"
  end

end
