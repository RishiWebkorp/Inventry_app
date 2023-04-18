class Item < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  has_many :allotments, dependent: :destroy
  has_many :issues, dependent: :destroy

  before_save :set_item_name

  def set_item_name
    self.name = "#{brand.name} #{name}"
  end
  
end
