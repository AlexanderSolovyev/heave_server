require "net/http"
require "uri"
class GoodsController < ApplicationController
  skip_before_action :authenticate_request, only: :image
  def list
    a=get_list
    a.slice!("catalog=")
    ##puts "spisok= #{a}"
    b=JSON.parse(a)
    ##puts b
  #  @goods=Good.all
    #puts @goods.to_json
    render json: b
  end
  def image
    #@good= Good.find_by_id(params[:id])
    #render json: @good
    send_file("#{Rails.root}/public/img/#{params[:id]}.png")
  end

  private

  def get_list
    #uri = URI.parse("http://app.heavesi.ee:8000/hv_copy/hs/mobile/GetCatalog")
    id = {
      'ID' => @current_user.id
    }
    uri = URI.parse("http://192.168.4.201/heavesi/hs/mobile/GetCatalog")
    req = Net::HTTP::Post.new(uri)
    req.body = id.to_json
    req.basic_auth 'exch', '13572468'
    res = Net::HTTP.start(uri.hostname, uri.port){ |http| http.request(req) }
    res.body
  end
end
