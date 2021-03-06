require "net/http"
require "uri"
class InvoiceController < ApplicationController
  def get_invoices
    a=get_from_1c
    a.slice!("orders=")
    b=JSON.parse(a)
    b.each do |x|
      if x["condition"] == "Выполнено"
        x["condition"]="done-all"
      elsif x["condition"]=="К выполнению"
        x["condition"]="checkmark"
      end
    end
    render json: b
  end

  def get_arved
    a=get_arved_from_1c
    puts "arved=#{a}"
    b=JSON.parse(a)
    b.each do |x|
      date=x["payDate"]
      puts Date.strptime(date,"%d.%m.%Y")
      if Date.strptime(x["payDate"],"%d.%m.%Y") < (Date.today-2000.years)
        x["color"]="danger"
      else
        x["color"]="primary"
      end
    end
    puts b
    render json: b
  end
end

private

def get_from_1c
  uri = URI.parse("#{PATH_1c}/hs/mobile/GetOrders")
  id = {
    #'ID' => @current_user.id
    'email' => @current_user.email
  }
  req = Net::HTTP::Post.new(uri)
  req.body = id.to_json
  req.basic_auth 'exch', '13572468'
  res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
  res.body
end

def get_arved_from_1c
  uri = URI.parse("#{PATH_1c}/hs/mobile/GetBills")
  id = {
    #'ID' => @current_user.id
    'email' => @current_user.email
  }
  req = Net::HTTP::Post.new(uri)
  req.body = id.to_json
  req.basic_auth 'exch', '13572468'
  res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
  puts res.message
  res.body
end
