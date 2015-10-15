class Issue < ActiveRecord::Base
  has_many :subscriptions
  has_many :responses
  belongs_to :place

  INVALID_PLACE_ID = -1

  has_attached_file :custom_image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :custom_image, :content_type => /\Aimage\/.*\Z/

  include DeletableAttachment

  def self.from_json json
    i = Issue.new
    i.id = json['id']
    i.status = json['status']
    i.summary = json['summary']
    i.description = json['description']
    i.lat = json['lat']
    i.lng = json['lng']
    i.address = json['address']
    i.scf_image_url = json['media']['image_square_100x100']
    i.created_at = Time.parse(json['created_at']).in_time_zone
    i.updated_at = Time.parse(json['updated_at']).in_time_zone
    i
  end

  def scf_url
    "http://seeclickfix.com/issues/#{id}"
  end

  def self.insert_or_update_from_json json_list, place_id
    # save them locally as issues
    json_list.collect do |issue_info|
      new_issue = Issue.from_json issue_info
      new_issue.place_id = place_id
      if Issue.exists?(:id=>new_issue[:id])
        Issue.find(new_issue[:id]).update new_issue.attributes
      else
        new_issue.save
      end
      new_issue
    end
  end

end
