class Log < ActiveRecord::Base

	def self.from_json_obj obj
		log = Log.new
		log.user_id = User.get_or_create_from_install_id(obj["installID"]).id
		log.install_id = obj["installID"]
		log.issue_id = Integer(obj["issueID"])
		log.action = obj["actionType"]
		log.timestamp = DateTime.parse(obj["timestamp"])
		log.lat = Float(obj["lat"]) unless obj["lat"].empty?
		log.lng = Float(obj["long"]) unless obj["long"].empty?
		log
	end

end
