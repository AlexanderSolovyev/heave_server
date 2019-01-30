require 'json_web_token'
require "net/http"
require "uri"
class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(email: @email) if user
  end

  private

  attr_accessor :email, :password

  def user
    result = get_user
    if (result.code == "200")
      data=JSON.parse(result.body)
      user = User.find_or_create_by(email: data["email"]) 
      user.update_attributes(name: data["name"], phone: data["phone"], reg_number: data["regNumber"])
      return user if user.save
    else
      errors.add :user_authentication, 'invalid_credentials'
      nil
    end
  end


  def get_user
    uri = URI.parse("#{PATH_1c}/hs/mobile/webConfirm")
    #                http://192.168.4.201/hv_copy/hs/mobile/GetConfirm
    #uri = URI.parse("http://212.7.4.74:8000/hv_copy/hs/GetConfirm?")
    info = {
      #Регномер компании, или Личный (Селект: [Erakliendi] - "isikukood" / [ärikliendi] - "Reg.kood")
      'email' => email,
      'pass' => password
      #'Confirm' => 'True' // из 1С
    }
    req = Net::HTTP::Post.new(uri)
    req.body = info.to_json
    req.basic_auth 'exch', '13572468'
    res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
    res
  end
end
