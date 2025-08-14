class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email, with: ->(e) { e.strip.downcase }

  validates :username, presence: true,
                       uniqueness: true,
                       length: { in: 3..20 },
                       format: { with: /\A[a-zA-Z_0-9]+\z/, message: "only allows letters, numbers and underscore" }
  validates :email, presence: true,
                    uniqueness: true
end
