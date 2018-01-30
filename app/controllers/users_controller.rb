class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def registration
    User.create(user_params)
    render json: { ok: 'registration completed'}, status: 200
  end

  private

  def user_params
    params.permit(:name, :email, :username, :password)
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
