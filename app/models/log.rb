class Log < ActiveRecord::Base

	def self.from_json_obj obj
		log = Log.new
		log.user_id = Install.get_or_create(obj["installID"]).id
		log.install_id = obj["installID"]
		log.issue_id = Integer(obj["issueID"])
		log.action = obj["actionType"]
		log.timestamp = Time.at(obj["timestamp"].to_i).to_datetime
		log.lat = Float(obj["lat"]) unless obj["lat"].empty?
		log.lng = Float(obj["lng"]) unless obj["lng"].empty?
		log
	end

end
