class UsersController < ApplicationController
  skip_before_action :authenticate_request

  def registration
    user=User.new(user_params_pass)
    if user.save
      SendUserJob.perform_later(user,@pass)
      render json: { ok: 'registration completed'}, status: 200
    else
      render json: {error: user.errors}, status: 500
    end
  end

  private

  def user_params_pass
    u = user_params
    @pass=create_pass
    u["password"]=@pass
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
