class User < ApplicationRecord
  has_secure_password
  has_many :receipts, dependent: :destroy
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
