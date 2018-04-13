class SearchesController < ApplicationController

  def search
  end

  def friends
    @friends = FoursquareService.new.friends(session[:token])
  end

  def foursquare
    client_id = ENV["FOURSQUARE_CLIENT_ID"]
    client_secret = ENV["FOURSQUARE_SECRET"]

    @venues = FoursquareService.new.foursquare(client_id, client_secret, params[:zipcode])

    render 'search'
  end
end
