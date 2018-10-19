class OrdersController < ApplicationController

  def show
    @orders=Order.all
    render json: @orders
  end

  def create
    params[:id]= @current_user.id
    @order=params.to_json
      SendOrderJob.perform_later @order
      # render json: { ok: 'order send'}, status: 200
    #else
    #  render json: { errors: @order.errors }, status: 500
    #end

  end

  private
  def order_params
    params.require(:order).permit(:id, :bottles, :returned_bottles, :information, :delivery_address, :delivery_time, :delivery_date)
  end
end
