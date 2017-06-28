require "httparty"
require "json"

class Kele
  include HTTParty

  def initialize(email, password)
    # @bloc_api = "https://www.bloc.io/api/v1/"
    response = self.class.post(api_url + "sessions", body: { "email": email, "password": password })
    # raise "Invalid email or password" if response.code == 404
    raise "Return code: " + response.code.to_s if response.code != 200
    @auth_token = response["auth_token"]
  end

  def get_me
    # @bloc_api = "https://www.bloc.io/api/v1/"
    response = self.class.get(api_url + "users/me", headers: { "authorization" => @auth_token })

    @user_data = JSON.parse(response.body)
  end

private

def api_url
  "https://www.bloc.io/api/v1/"
end

end
