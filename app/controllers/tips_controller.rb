class TipsController < ApplicationController
  def index
    @results = FoursquareService.new.tips(session[:token])
  end

  def create
    FoursquareService.new.tip_create(session[:token], params[:venue_id], params[:tip])

    redirect_to tips_path
  end
end
