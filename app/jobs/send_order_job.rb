require "net/http"
require "uri"
class SendOrderJob < ApplicationJob
  queue_as :default

  def perform(order)
    uri = URI.parse("http://212.7.4.74:8000/hv_copy/hs/mobileorders?PutOrder")

    data = {'id' => order.user_id,
            'bottles' => order.bottles,
            'returnedBottles' => order.returned_bottles,
            'deliveryAddress'=> order.delivery_address,
            'deliveryDate' => order.delivery_date,
            'deliveryTime' => order.delivery_time,
            'information' => order.information
    }
    req = Net::HTTP::Post.new(uri)
    req.body = data.to_json
    req.basic_auth 'exch', '13572468'
    res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
  end

end
