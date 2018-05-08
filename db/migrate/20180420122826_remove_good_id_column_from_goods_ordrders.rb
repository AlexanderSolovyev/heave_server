class RemoveGoodIdColumnFromGoodsOrdrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :goods_orders, :good_id
  end
end
