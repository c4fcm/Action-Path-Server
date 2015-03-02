class IssuesController < ApplicationController
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
