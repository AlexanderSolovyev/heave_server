class OrdersController < ApplicationController

  def show
    @orders=Order.all
    render json: @orders
  end

  def create
    @order=Order.new(order_params)
    @order[:user_id]=@current_user.id
    if @order.save
      SendOrderJob.perform_later @order
      render status: 200
    else
      render json: { errors: @order.errors }
    end
  end

  private
  def order_params
    params.require(:order).permit(:id, :bottles, :returned_bottles, :information, :delivery_address, :delivery_time, :delivery_date)
    end
end