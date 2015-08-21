class Log < ActiveRecord::Base

	def self.from_json_obj obj
		install = Install.get_or_create(obj["installId"]).id
		log = Log.new
		log.install_id = install.id
		log.issue_id = Integer(obj["issueId"])
		log.action = obj["actionType"]
		log.timestamp = Time.at(obj["timestamp"].to_i).to_datetime
		log.lat = Float(obj["lat"]) unless obj["lat"].empty?
		log.lng = Float(obj["lng"]) unless obj["lng"].empty?
		log
	end

end
