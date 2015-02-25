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
      :image_full => "http://seeclickfix.com/files/comment_images/0001/3476/32eebb4f8669b5beb441280bc16f26bf.jpeg"
    }
    render :json => @issue
  end
end
