class OrderGarment < ActiveRecord::Base
  belongs_to :order
  belongs_to :garment
end
