class Log < ActiveRecord::Base

	def self.from_json_obj obj
		log = Log.new
		log.type = "action"
		log.user_id = Integer(obj.userID)
		log.issue_id = Integer(obj.issueID)
		log.action = obj.actionType
		log.timestamp = DateTime.parse(obj.timestamp)
		log.lat = Float(log.lat)
		log.lng = Float(log.long)
		log
	end

end
