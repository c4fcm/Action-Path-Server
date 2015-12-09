class StatsController < ApplicationController

  def stats_by_request_type
    @installs_by_request_type = Install.count_by_request_type
    @stats_by_request_type  = @installs_by_request_type.collect do |request_type,count|
      {
        :installs => Install.with_request_type(request_type),
        :request_type => request_type,
        :count => count,
        :geofences_entered => Log.count_by_action(Log::ACTION_ENTERED_GEOFENCE,request_type),
        :geofence_notifications_clicked => Log.count_by_action(Log::ACTION_CLICKED_ON_SURVEY_NOTIFICATION,request_type),
        :responses => Response.count_for_request_type(request_type),
        :responses_logs => Log.count_by_action(Log::ACTION_RESPONDED_TO_QUESTION,request_type),
        :responses_from_notification => Log.count_by_action(Log::ACTION_RESPONDED_TO_QUESTION_FROM_GEOFENCE_NOTIFICATION,request_type)
      }
    end
    @geofences_entered = Log.count_by_action(Log::ACTION_ENTERED_GEOFENCE)
    @geofence_notifications_clicked = Log.count_by_action(Log::ACTION_CLICKED_ON_SURVEY_NOTIFICATION)
    @clicks_by_menu_item = Log.count_by_action(Log::ALL_MENU_ACTIONS)
    @total_menu_item_clicks = @clicks_by_menu_item.inject(0){|sum, item| sum + item[:clicks]}
    @issue_updated_notifications = Log.count_by_action(Log::ACTION_ISSUE_STATUS_UPDATED)
    @issue_updated_clicks = Log.count_by_action(Log::ACTION_CLICKED_ON_UPDATE_NOTIFICATION)
  end

  def notification_paths
  	@geofence_notification_counts = Log::count_by_action(Log::ACTION_ENTERED_GEOFENCE)
  	@geofence_notifications_clicked = Log.count_by_action(Log::ACTION_CLICKED_ON_SURVEY_NOTIFICATION)
  	Log::by_action(Log::ACTION_ENTERED_GEOFENCE).each { |log|
  		log
  	}
  end

end
