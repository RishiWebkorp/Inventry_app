class Allotment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  belongs_to :category
  
end
