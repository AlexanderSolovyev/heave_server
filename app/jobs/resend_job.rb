require "net/http"
require "uri"
class ResendJob < ApplicationJob
  queue_as :default

  def perform(user)
   #uri = URI.parse("http://212.7.4.74:8000/hv_copy/hs/mobileConfirmgetConfirm")
	uri = URI.parse("http://192.168.4.201/hv_copy/hs/mobile/GetConfirm")
    info = {
      'regNumber' => user.reg_number,
      'name' => user.name,
      'email' => user.email,
      'phone' => user.phone,
      'ID' => user.id
    }
    #puts "++++++++++++++++++++ #{info}"
    req = Net::HTTP::Post.new(uri)
    req.body = info.to_json
    req.basic_auth 'exch', '13572468'
    res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
  end
end
