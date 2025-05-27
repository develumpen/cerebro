class Receipt < ApplicationRecord
  has_many_attached :photos

  validates_presence_of :description
end
