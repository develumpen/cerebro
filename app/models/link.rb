class Link < ApplicationRecord
  validates :url, presence: true
  validate :url_has_scheme_and_host
  validates :title, presence: true

  private

  def url_has_scheme_and_host
    return unless url.present?

    uri = URI.parse(url)
    valid_scheme = uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    valid_host = uri.host.present? && uri.host.include?(".")

    unless valid_scheme && valid_host
      errors.add(:url, "is not valid")
    end
  end
end
