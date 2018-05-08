class GoodsOrder < ApplicationRecord
  belongs_to :order
  belongs_to :good
end
