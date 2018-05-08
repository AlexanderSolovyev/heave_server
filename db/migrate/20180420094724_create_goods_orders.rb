class CreateGoodsOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :goods_orders do |t|
      t.string :goods_quantity
      t.string :image_url
      t.string :id_1c
      t.belongs_to :order, index: true
      t.timestamps
    end
  end
end
