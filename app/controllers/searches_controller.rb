class SearchesController < ApplicationController

  def search
  end

  def friends
    foursquare = FoursquareService.new
    @friends = foursquare.friends(session[:token])
  end

  def foursquare
    client_id = ENV['FOURSQUARE_CLIENT_ID']
    client_secret = ENV['FOURSQUARE_SECRET']

    foursquare = FoursquareService.new
    @venues = foursquare.foursquare(client_id, client_secret, params)

    # TODO - figure out how to reinstate the error handling
    # I assume the below bits must move to the service method (because the .success? method fails when called on the returned response hash), but will return simply the venues content or the error content. would @variables carry across? hmmm. 

    # if @resp.success?
    #   @venues = body["response"]["venues"]
    # else
    #   @error = body["meta"]["errorDetail"]
    # end
    render 'search'

    # rescue Faraday::TimeoutError
    #   @error = "There was a timeout. Please try again."
    #   render 'search'
  end
end
