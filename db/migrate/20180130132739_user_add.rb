class UserAdd < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reg_number, :string
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :confirm, :boolean, :default => false
  end
end
