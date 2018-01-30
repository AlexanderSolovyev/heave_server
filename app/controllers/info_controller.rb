class InfoController < ApplicationController
  def show
    render json: { data: @current_user}, status: 200
  end
end
