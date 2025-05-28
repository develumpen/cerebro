class Receipt < ApplicationRecord
  has_many_attached :photos do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 300, nil ]
  end

  validates_presence_of :description, :purchased_at
  validates :currency, inclusion: { in: %w[usd eur], message: "%{value} is not a valid currency" }
end
