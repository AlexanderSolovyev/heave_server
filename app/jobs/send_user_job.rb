require "net/http"
require "uri"
class SendUserJob < ApplicationJob
  queue_as :default

  def perform(user,pass)
    uri = URI.parse("http://192.168.4.201/heavesi/hs/mobile/GetConfirm")
    #                http://192.168.4.201/hv_copy/hs/mobile/GetConfirm
    #uri = URI.parse("http://212.7.4.74:8000/hv_copy/hs/GetConfirm?")
    info = {
      #Регномер компании, или Личный (Селект: [Erakliendi] - "isikukood" / [ärikliendi] - "Reg.kood")
      'regNumber' => user.reg_number,
      'name' => user.name,
      'email' => user.email,
      'phone' => user.phone,
      'pass' => pass,
      'ID' => user.id
      #'Confirm' => 'True' // из 1С
    }
    req = Net::HTTP::Post.new(uri)
    req.body = info.to_json
    req.basic_auth 'exch', '13572468'
    res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
  end
end
