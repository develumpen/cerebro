require "test_helper"

class ReceiptTest < ActiveSupport::TestCase
  test "has photo" do
    receipt = receipts(:with_photos)

    assert receipt.photos.attached?
  end
end
