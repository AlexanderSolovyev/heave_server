require "net/http"
require "uri"
class SendOrderJob < ApplicationJob
  queue_as :default

  def perform(order)
    uri = URI.parse("http://app.heavesi.ee:8000/hv_copy/hs/mobileorders?PutOrder")

    ##data = {'id' => order.user_id,
    ##        'bottles' => order.bottles,
    ##        'returnedBottles' => order.returned_bottles,
    ##        'deliveryAddress'=> order.delivery_address,
    ##        'deliveryDate' => order.delivery_date,
    ##        'deliveryTime' => order.delivery_time,
    ##        'information' => order.information
    ##}
    o=JSON.parse(order)
    data = {
      'Id' => o["id"],
      'deliveryDate' => o["delivery_date"],
      'deliveryTime' => o["delivery_time"],
      'deliveryAddress'=> o["delivery_address"],
      'information' => o["information"],
      'bottles' => o["bottles"],
      'returnedBottles' => o["returned_bottles"],
      'Goods' => o["goods"]

    }
    puts "data ============#{data.to_json}"
    req = Net::HTTP::Post.new(uri)
    req.body = data.to_json
    req.basic_auth 'exch', '13572468'
    res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
  end

end
