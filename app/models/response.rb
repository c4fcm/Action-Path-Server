class Response < ActiveRecord::Base

	belongs_to :issue
	belongs_to :install

	has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

	def self.from_json_obj obj
		install = Install.get_or_create(obj["installId"])
		response = Response.new
		response.answer = obj["answerText"]
		response.comment = obj["comment"]
		response.install_id = install.id
		response.issue_id = Integer(obj["issueId"])
		response.timestamp = Time.at(obj["timestamp"].to_i).to_datetime
		response.lat = Float(obj["lat"]) unless obj["lat"].empty?
		response.lng = Float(obj["lng"]) unless obj["lng"].empty?
		response
	end

	def self.on_issues_from_others(issue_ids, install_device_id, after_time)
	  includes(:install).
	  	references(:install).
		where('installs.device_id != ?', install_device_id).
	  	where(:issue_id => issue_ids).
	  	where("responses.created_at > ?", after_time)
	end

end
