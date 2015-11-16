class Log < ActiveRecord::Base

	belongs_to :install

	ACTION_ENTERED_GEOFENCE = "EnteredGeofence"
	ACTION_CLICKED_ON_SURVEY_NOTIFICATION = "ClickedOnSurveyNotification"
	ACTION_RESPONDED_TO_QUESTION_FROM_GEOFENCE_NOTIFICATION = "ResponsedToSurveyFromGeofenceNotification"

	def self.from_json_obj obj
		install = Install.get_or_create(obj["installId"])
		log = Log.new
		log.install_id = install.id
		log.issue_id = Integer(obj["issueId"])
		log.action = obj["actionType"]
		log.details = obj["details"]
		log.timestamp = Time.at(obj["timestamp"].to_i).to_datetime
		log.lat = Float(obj["lat"]) unless obj["lat"].empty?
		log.lng = Float(obj["lng"]) unless obj["lng"].empty?
		log
	end

	def self.geofence_click_rate(device_id)
		entered = where(:install_id=>device_id).where(:action=>ACTION_ENTERED_GEOFENCE).count
		return 0 if entered.zero?
		clicked = where(:install_id=>device_id).where(:action=>ACTION_CLICKED_ON_SURVEY_NOTIFICATION).count
		clicked/entered
	end

	def self.geofence_response_rate(device_id)
		entered = where(:install_id=>device_id).where(:action=>ACTION_ENTERED_GEOFENCE).count
		return 0 if entered.zero?
		responded = where(:install_id=>device_id).where(:action=>ACTION_RESPONDED_TO_QUESTION_FROM_GEOFENCE_NOTIFICATION).count
		responded/entered
	end

end
