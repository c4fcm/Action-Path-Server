class Place < ActiveRecord::Base
  has_many :issues

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
