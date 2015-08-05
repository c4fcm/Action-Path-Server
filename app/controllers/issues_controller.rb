require 'see_click_fix'

class IssuesController < ApplicationController
  
  def index
    if params[:place_id] and params[:place_id].to_i>0 then
      place_id = params[:place_id]
      # first make sure the place is in our db locally
      if not Place.exists?(:id => place_id)
        logger.info("Adding new place %d" % place_id)
        place_info = SeeClickFix.place(place_id)
        new_place = Place.from_json place_info
        new_place.save
      end
      place = Place.find(place_id)
      if place.issues_fetched_at.nil? or place.issues_fetched_at < 6.hours.ago
        place.update(issues_fetched_at: DateTime.now)
        # fetch all the latest issues
        issues_list = SeeClickFix.lastest_issues(place.url_name)['issues']
        # save them locally
        issues_list.each do |issue_info|
          new_issue = Issue.from_json issue_info
          new_issue.place_id = place_id
          if Issue.exists?(:id=>new_issue[:id])
            Issue.find(new_issue[:id]).update new_issue.attributes
          else
            new_issue.save
          end
        end
        logger.info("Fetched and tried to save #{issues_list.count} new issues from place #{place_id}" )
      end
      # return results to client
      @issues = Issue.where({:place_id => place_id})
    else
      @issues = []
    end
    render :json => @issues
  end
  
end
