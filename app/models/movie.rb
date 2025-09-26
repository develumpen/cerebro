class Movie < ApplicationRecord
  validates :title, presence: true
  validates :tmdb_id, presence: true
end
