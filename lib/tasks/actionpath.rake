require 'net/http'
require 'uri'

namespace :actionpath do
  desc "Tasks for the actionpath.org api server."
  task fetch_issues: :environment do
    api = "https://seeclickfix.com/api/v2/"
    uri = URI.parse("%sissues" % api)
    Place.all().each do |place|
      params = { place_url: place.url_name }
      uri.query = URI.encode_www_form(params) 
      res = JSON.parse(Net::HTTP.get_response(uri).body)
      puts res
      res["issues"].each do |res_issue|
        issue = {
          :id => res_issue["id"],
          :status => res_issue["status"],
          :summary => res_issue["summary"],
          :description => res_issue["description"],
          :lat => res_issue["lat"],
          :lng => res_issue["lng"],
          :address => res_issue["address"],
          :image_full => res_issue["media"]["image_full"]
        }
        Issue.create(issue)
      end
      # Don't overload the seeclickfix server
      sleep(1)
    end
  end

end
