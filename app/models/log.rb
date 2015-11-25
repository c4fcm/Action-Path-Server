class Log < ActiveRecord::Base

	belongs_to :install

	# keey in sync with mobile app LogMsg constants
	ACTION_CLICKED_ON_ISSUE_IN_LIST = "ClickOnIssueInList"
	ACTION_FOLLOWED_ISSUE_FROM_FOLLOW_BUTTON = "FollowedIssueFromFollowButton"
	ACTION_UNFOLLOWED_ISSUE_FROM_FOLLOW_BUTTON = "UnfollowedIssueFromFollowButton"
	ACTION_FOLLOWED_ISSUE_BY_ANSWERING = "FollowedIssueFromAnswer"
	ACTION_CLICKED_ON_SURVEY_NOTIFICATION = "ClickedOnSurveyNotification"
	ACTION_CLICKED_ON_UPDATED_ISSUES_NOTIFICATION = "ClickedOnUpdatedIssuesNotification"
	ACTION_RESPONDED_TO_QUESTION = "ResponsedToSurvey"
	ACTION_RESPONDED_TO_QUESTION_FROM_GEOFENCE_NOTIFICATION = "ResponsedToSurveyFromGeofenceNotification"
	ACTION_ENTERED_GEOFENCE = "EnteredGeofence"
	ACTION_LOADED_LATEST_ISSUES = "LoadedLatestIssues"
	ACTION_INSTALLED_APP = "InstalledApp"
	ACTION_ISSUE_STATUS_UPDATED = "IssueStatusChanged"
	ACTION_CREATED_ISSUE = "CreatedIssueInDB"
	ACTION_PICKED_PLACE= "PickedPlace"
	ACTION_CLICKED_ABOUT = "ClickedAboutMenuItem"
	ACTION_CLICKED_STATS = "ClickedStatsMenuItem"
	ACTION_CLICKED_RECENTLY_UPDATED_ISSUES = "ClickedRecentlyUpdatedIssuesMenuItem"
	ACTION_CLICKED_MY_ISSUES = "ClickedMyIssuesMenuItem"
	ACTION_CLICKED_ISSUES_MAP = "ClickedIssuesMapMenuItem"
	ACTION_CLICKED_ALL_ISSUES = "ClickedAllIssuesMenuItem"
	ACTION_CLICKED_UPDATE_ISSUES = "ClickedUpdateIssuesMenuItem"
	ACTION_BACKGROUND_TASK_UPDATED_ISSUES = "BackgroundTaskUpdatedIssues"
	ACTION_CLICKED_PICK_PLACE = "ClickedPickPlaceMenuItem"
	ACTION_CLICKED_HOME = "ClickedHomeMenuItem"
	ACTION_CLICKED_ON_UPDATE_NOTIFICATION="ClicksOnUpdateNotification"
	ACTION_SAVING_DEBUG_INFO = "SaveDebugInfo"
	ACTION_PICKED_REQUEST_TYPE = "PickedRequestType"

	ALL_MENU_ACTIONS = [
		ACTION_CLICKED_HOME, 
		ACTION_CLICKED_ISSUES_MAP, 
		ACTION_CLICKED_MY_ISSUES, 
		ACTION_CLICKED_RECENTLY_UPDATED_ISSUES, 
		ACTION_CLICKED_ALL_ISSUES, 
		ACTION_CLICKED_UPDATE_ISSUES, 
		ACTION_CLICKED_STATS, 
		ACTION_CLICKED_ABOUT, 
		ACTION_CLICKED_PICK_PLACE
	]

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
		entered = joins(:install).where("installs.is_real=?",true).
			where(:install_id=>device_id).where(:action=>ACTION_ENTERED_GEOFENCE).count
		return 0 if entered.zero?
		clicked = joins(:install).where("installs.is_real=?",true).
			where(:install_id=>device_id).where(:action=>ACTION_CLICKED_ON_SURVEY_NOTIFICATION).count
		clicked.to_f/entered.to_f
	end

	def self.geofence_response_rate(device_id)
		entered = joins(:install).where("installs.is_real=?",true).
			where(:install_id=>device_id).where(:action=>ACTION_ENTERED_GEOFENCE).count
		return 0 if entered.zero?
		responded = joins(:install).where("installs.is_real=?",true).
			where(:install_id=>device_id).where(:action=>ACTION_RESPONDED_TO_QUESTION_FROM_GEOFENCE_NOTIFICATION).count
		responded.to_f/entered.to_f
	end

	def self.count_by_action(type, request_type=nil)
		if type.kind_of? Array
			return type.collect { |t| {:item=>t.sub("Clicked","").sub("MenuItem",""), 
									   :clicks=>count_by_action(t)} }
		else
			if request_type.nil? 
				return joins(:install).where("installs.is_real=?",true).where(:action=>type).count()
			else
				return joins(:install).
					where("installs.is_real=?",true).
					where("installs.request_type = ?",request_type).
					where(:action=>type).count()
			end
			
		end
	end

end
