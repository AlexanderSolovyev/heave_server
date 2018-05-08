class CreateGoods < ActiveRecord::Migration[5.1]
  def change
    create_table :goods do |t|
      t.string :good_name
      t.string :price
      t.string :image_url
      t.belongs_to :goods_order, index: true

      t.timestamps
    end
  end
end
