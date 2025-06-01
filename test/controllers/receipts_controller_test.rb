require "test_helper"

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  include AuthHelper

  test "should get index" do
    sign_in users(:one)

    get receipts_url

    assert_response :success
  end

  test "should show receipt" do
    sign_in users(:one)

    receipt = receipts(:with_photos)

    get receipt_url(receipt)

    assert_response :success
  end

  test "should report not found for invalid id" do
    sign_in users(:one)

    get receipt_url("invalid-id")

    assert_response :not_found
  end

  test "should get new" do
    sign_in users(:one)

    get new_receipt_url

    assert_response :success
  end

  test "should create receipt with valid attributes" do
    sign_in users(:one)

    assert_difference("Receipt.count") do
      post receipts_url, params: {
        receipt: {
          purchased_at: Time.current,
          description: "New Receipt",
          amount: 15050,
          currency: "eur"
        }
      }
    end

    assert_redirected_to receipt_url(Receipt.last)
    assert_equal "Receipt was successfully created.", flash[:notice]
    assert_not Receipt.last.photos.attached?
  end

  test "should create receipt with photos" do
    sign_in users(:one)

    assert_difference("Receipt.count") do
      post receipts_url, params: {
        receipt: {
          purchased_at: Time.current,
          description: "Receipt with photo",
          amount: 15050,
          currency: "eur",
          photos: [ file_fixture_upload("receipt.jpg", "image/jpeg") ]
        }
      }
    end

    assert_redirected_to receipt_url(Receipt.last)
    assert Receipt.last.photos.attached?
  end

  test "should not create receipt with invalid attributes" do
    sign_in users(:one)

    assert_no_difference("Receipt.count") do
      post receipts_url, params: {
        receipt: {
          purchased_at: nil,
          description: nil,
          amount: nil,
          currency: nil
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    sign_in users(:one)

    receipt = receipts(:with_photos)

    get edit_receipt_url(receipt)

    assert_response :success
  end

  test "should update receipt with valid attributes" do
    sign_in users(:one)

    receipt = receipts(:with_photos)

    patch receipt_url(receipt), params: {
      receipt: {
        description: "Updated description",
        purchased_at: 1.day.ago,
        amount: 30000,
        currency: "usd"
      }
    }

    receipt.reload

    assert_redirected_to receipt_url(receipt)
    assert_equal "Updated description", receipt.description
    assert_equal 30000, receipt.amount
    assert_equal "Receipt was successfully updated.", flash[:notice]
  end

  test "should not update receipt with invalid attributes" do
    sign_in users(:one)

    receipt = receipts(:with_photos)

    patch receipt_url(receipt), params: {
      receipt: {
        description: "",
        purchased_at: nil
      }
    }

    assert_response :unprocessable_entity
  end

  test "should update receipt with photo" do
    sign_in users(:one)

    receipt = receipts(:without_photos)

    assert_not receipt.photos.attached?

    patch receipt_url(receipt), params: {
      receipt: {
        photos: [ file_fixture_upload("receipt.jpg", "image/jpeg") ]
      }
    }

    receipt.reload

    assert_redirected_to receipt_url(receipt)
    assert receipt.photos.attached?
  end

  test "should remove photos from receipt" do
    sign_in users(:one)

    receipt = receipts(:with_photos)

    assert receipt.photos.attached?

    patch receipt_url(receipt), params: {
      receipt: {
        photos: []
      }
    }

    receipt.reload

    assert_not receipt.photos.attached?
  end

  test "should destroy receipt" do
    sign_in users(:one)

    receipt = receipts(:with_photos)

    assert_difference("Receipt.count", -1) do
      delete receipt_url(receipt)
    end

    assert_redirected_to receipts_path
    assert_equal "Receipt was successfully destroyed.", flash[:notice]
  end
end
