class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def registration
    User.create(user_params_pass)
    render json: { ok: 'registration completed'}, status: 200
  end

  private

  def user_params_pass
    u = user_params
    u["password"]=create_pass
    return u
  end
  def user_params
    params.require(:user).permit(:name, :email, :phone, :reg_number)
  end

  def create_pass
    "123456"
    #pass=Random.new
    #pass.rand(1000...10000).to_s
  end
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
