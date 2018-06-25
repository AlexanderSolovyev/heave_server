require "net/http"
require "uri"
class InvoiceController < ApplicationController
  def get_invoices
    a=get_from_1c
    a.slice!("orders=")

    b=JSON.parse(a)
    #puts b
    b.each do |x|
      if x["condition"] == "Выполнено"
        x["condition"]="md-done-all"
      elsif x["condition"]=="К выполнению"
        x["condition"]="md-checkmark"
      end
    end
    puts b
  #  @goods=Good.all
    #puts @goods.to_json
    render json: b
  end
end

private
def get_from_1c
  uri = URI.parse("http://app.heavesi.ee/hv_copy/hs/mobile/GetOrders")
  id = {
    'ID' => @current_user.id
  }
  req = Net::HTTP::Post.new(uri)
  req.body = id.to_json
  req.basic_auth 'exch', '13572468'
  res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
  res.body
end
