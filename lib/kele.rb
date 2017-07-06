require "httparty"
require "json"
require "roadmap"

class Kele
  include HTTParty
  include Roadmap

  def initialize(email, password)
    response = self.class.post(api_url + "sessions", body: { "email": email, "password": password })
    raise "Invalid email or password" if response.code != 200
    @email = email
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get(api_url + "users/me", headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get(api_url + "mentors/#{mentor_id}/student_availability", headers: {"authorization" => @auth_token})
    @mentor_availability = JSON.parse(response.body)
  end

  def get_messages(page)
    response = self.class.get(api_url + "message_threads?page=#{page}", headers: {"authorization" => @auth_token})
    @messages = JSON.parse(response.body)
  end

  def create_message(sender_email, recipient_id, subject, message)
    response = self.class.post(api_url + "messages", body: { "sender": "megan.wilkin@blueostrichdesign.co.uk", "recipient_id": recipient_id,"subject": subject, "stripped-text": message }, headers: {"authorization" => @auth_token})
    puts response.body
  end


private

def api_url
  "https://www.bloc.io/api/v1/"
end

end
