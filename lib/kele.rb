require "httparty"

class Kele
  include HTTParty

  def initialize(email, password)
    @bloc_api = "https://www.bloc.io/api/v1/#"
    response = self.class.post(@bloc_api + "sessions", body: { "email": email, "password": password })
    raise "Invalid email or password" if response.code == 401
    @auth_token = response["auth_token"]
  end
end
