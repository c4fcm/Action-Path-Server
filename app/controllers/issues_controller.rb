class IssuesController < ApplicationController
  def index
    if params[:place_id] then
      @issues = Issue.where({:place_id => params[:place_id]})
    else
      @issues = Issue.all()
    end
    render :json => @issues
  end
  def show
    @issue = Issue.find(params[:id])
    render :json => @issue
  end
end
