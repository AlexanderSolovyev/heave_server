class AddReferenceToGoodsOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :goods_orders, :good
  end
end
