require "test_helper"

class ReceiptTest < ActiveSupport::TestCase
  setup do
    @receipt = receipts(:with_photos)
  end

  test "has photo" do
    assert @receipt.photos.attached?
  end

  test "invalid with non accepted currency" do
    @receipt.currency = "gbp"

    assert_not @receipt.valid?
    assert_not_empty @receipt.errors[:currency]
  end
end
