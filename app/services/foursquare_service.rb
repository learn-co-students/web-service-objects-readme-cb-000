class FoursquareService

  def generate_url!(client_id, redirect_url)
    redirect_uri = CGI.escape(redirect_url)
    foursquare_url = "https://foursquare.com/oauth2/authenticate?client_id=#{client_id}&response_type=code&redirect_uri=#{redirect_uri}"
    return foursquare_url
  end

  def authenticate!(client_id, client_secret, code)
    resp = Faraday.get "https://foursquare.com/oauth2/access_token" do |req|
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = code
    end
    body = JSON.parse(resp.body)
    body["access_token"]
  end

  def friends(token)
    resp = Faraday.get "https://api.foursquare.com/v2/users/self/friends" do |req|
      req.params['oauth_token'] = token
      req.params['v'] = '20160201'
    end
    JSON.parse(resp.body)["response"]["friends"]["items"]
  end

end
