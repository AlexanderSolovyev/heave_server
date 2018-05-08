class Order < ApplicationRecord
  belongs_to :user
  has_many :goods_orders
end
