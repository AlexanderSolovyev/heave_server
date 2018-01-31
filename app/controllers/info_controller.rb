class InfoController < ApplicationController
  def show
    render json: { info: @current_user}, status: 200
  end
end
