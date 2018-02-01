class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.string :bottles
      t.string :returned_bottles
      t.string :delivery_address
      t.string :delivery_date
      t.string :delivery_time
      t.string :information
      t.timestamps
    end
  end
end
