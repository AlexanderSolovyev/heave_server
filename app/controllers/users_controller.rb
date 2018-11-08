require 'net/http'
class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def registration
    user=User.new(user_params)
    tok=token
    res =reg user, tok
    result = JSON.parse(res.body)
    byebug
    if (res.code == "201")
      render json: {}, status: 200
    else
      render json: {error: result["message"]}, status: 500
    end
    #if user.save
    #  SendUserJob.perform_later(user,@pass)
     #  render json: { ok: 'registration completed'}, status: 200
    #else
    #  render json: {error: user.errors}, status: 500
    #end
  end

  #def resend
  #  @user=User.find_by email: user_params[:email]
  #  if @user
#      ResendJob.perform_later(@user)
#    else
#      render json: { error: 'email not found' }, status: 500
#    end
  #end

  private

  def token
    uri = URI.parse("https://heavesi.ee/wp-json/jwt-auth/v1/token")
    #                http://192.168.4.201/hv_copy/hs/mobile/GetConfirm
    #uri = URI.parse("http://212.7.4.74:8000/hv_copy/hs/GetConfirm?")
    info = {
      'username' => 'mobileapp@heavesi.ee',
      'password' => 'BjwYKyVJO&)$4e0Jls$W&Dj)'
    }
    req = Net::HTTP::Post.new(uri)
    req.content_type = "application/json"
    req.add_field("cache-control", "no-cache")
    req.body = info.to_json
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https'){ |http| http.request(req) }
    result = JSON.parse(res.body)
    result["token"]
  end

  def reg (user,token)
    uri = URI.parse("https://heavesi.ee/wp-json/wc/v2/customers")
    info = {
      "username" => user.name,
      "password" => user.password,
      "first_name" => user.name,
      "email" => user.email,
      "billing" => { "phone" => user.phone},
      "meta_data" => [{"key" => "reg_number", "value" => user.reg_number}]
    }
    req = Net::HTTP::Post.new(uri)
    req.content_type = "application/json"
    req.add_field("cache-control", "no-cache")
    req.add_field("Authorization", "Bearer "+token)
    req.body = info.to_json
    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https'){ |http| http.request(req) }

  end

  #def user_params_pass
  #  u = user_params
  #  @pass=create_pass
  #  u["password"]=@pass
  #  return u
  #end
  def user_params
    params.require(:user).permit(:name, :email, :phone, :reg_number, :password)
  end

  #def create_pass
    #"123456"
  #  pass=Random.new
  #  pass.rand(100000...1000000).to_s
  #end
end
#  info = {
#      'regNumber' => '' #Регномер компании, или Личный (Селект: [Erakliendi] - "isikukood" / [ärikliendi] - "Reg.kood")
#      'name' => ''
#      'email' => '1430@list.ru',
#      'phone' => ''
#      'pass' => '12345'
#      'ID' => ''
#      'Confirm' => 'True' // из 1С
#    }
