class IssuesController < ApplicationController
  def index
    @issues = [
      {
        :status => "Open",
        :summary => "Pothole",
        :description => "Please fix my neighborhood.",
        :lat => 42.30293,
        :lng => -72.234234234,
        :address => "123 State St. New Haven, CT",
        :image_full => "https://pbs.twimg.com/media/BrTlTtRIEAAU7jv.jpg:large"
      }, {
        :status => "Open",
        :summary => "Abandoned car",
        :description => "Illegally parked",
        :lat => 42.359789,
        :lng => -71.091843,
        :address => "222 Memorial Dr. Cambridge, MA",
        :image_full => "http://hacks.mit.edu/Hacks/by_year/1994/cp_car/heliNOT-ap-photo_smcrp.gif"
      }
    ]
    render :json => @issues
  end
  def show
    #@issue = Issue.find(params[:id])
    @issue = {
      :status => "Open",
      :summary => "Pothole",
      :description => "Please fix my neighborhood.",
      :lat => 42.30293,
      :lng => -72.234234234,
      :address => "123 State St. New Haven, CT",
      :image_full => "https://pbs.twimg.com/media/BrTlTtRIEAAU7jv.jpg:large"
    }
    render :json => @issue
  end
end
