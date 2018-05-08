class RemoveColumnFromGoods < ActiveRecord::Migration[5.1]
  def change
    remove_column :goods, :goods_order_id
  end
end
