require "test_helper"

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  include AuthHelper

  class GuestUserTest < ReceiptsControllerTest
    test "index should redirect to sign in" do
      get receipts_url

      assert_redirected_to new_session_url
    end

    test "show should redirect to sign in" do
      receipt = receipts(:with_photos)

      get receipt_url(receipt)

      assert_redirected_to new_session_url
    end

    test "new should redirect to sign in" do
      get new_receipt_url

      assert_redirected_to new_session_url
    end

    test "create should redirect to sign in" do
      assert_no_difference("Receipt.count") do
        post receipts_url, params: {
          receipt: {
            purchased_at: Time.current,
            description: "New Receipt",
            amount: 15050,
            currency: "eur"
          }
        }
      end

      assert_redirected_to new_session_url
    end
  end

  class AuthenticatedUserTest < ReceiptsControllerTest
    setup do
      sign_in users(:one)
    end

    test "should get index" do
      get receipts_url

      assert_response :success
    end

    test "should get new" do
      get new_receipt_url

      assert_response :success
    end

    test "should create receipt with valid attributes" do
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
  end

  class OwnerTest < ReceiptsControllerTest
    setup do
      sign_in users(:one)

      @receipt_with_photos = receipts(:with_photos)
      @receipt_without_photos = receipts(:without_photos)
    end
    test "should show receipt" do
      get receipt_url(@receipt_with_photos)

      assert_response :success
    end

    test "should report not found for invalid id" do
      get receipt_url("invalid-id")

      assert_response :not_found
    end

    test "should get edit" do
      get edit_receipt_url(@receipt_with_photos)

      assert_response :success
    end

    test "should update receipt with valid attributes" do
      patch receipt_url(@receipt_with_photos), params: {
        receipt: {
          description: "Updated description",
          purchased_at: 1.day.ago,
          amount: 30000,
          currency: "usd"
        }
      }

      @receipt_with_photos.reload

      assert_redirected_to receipt_url(@receipt_with_photos)
      assert_equal "Updated description", @receipt_with_photos.description
      assert_equal 30000, @receipt_with_photos.amount
      assert_equal "Receipt was successfully updated.", flash[:notice]
    end

    test "should not update receipt with invalid attributes" do
      patch receipt_url(@receipt_with_photos), params: {
        receipt: {
          description: "",
          purchased_at: nil
        }
      }

      assert_response :unprocessable_entity
    end

    test "should update receipt with photo" do
      assert_not @receipt_without_photos.photos.attached?

      patch receipt_url(@receipt_without_photos), params: {
        receipt: {
          photos: [ file_fixture_upload("receipt.jpg", "image/jpeg") ]
        }
      }

      @receipt_without_photos.reload

      assert_redirected_to receipt_url(@receipt_without_photos)
      assert @receipt_without_photos.photos.attached?
    end

    test "should remove photos from receipt" do
      assert @receipt_with_photos.photos.attached?

      patch receipt_url(@receipt_with_photos), params: {
        receipt: {
          photos: []
        }
      }

      @receipt_with_photos.reload

      assert_not @receipt_with_photos.photos.attached?
    end

    test "should destroy receipt" do
      assert_difference("Receipt.count", -1) do
        delete receipt_url(@receipt_with_photos)
      end

      assert_redirected_to receipts_path
      assert_equal "Receipt was successfully destroyed.", flash[:notice]
    end
  end

  class NonOwnerTest < ReceiptsControllerTest
    setup do
      sign_in users(:two)
      @receipt = receipts(:with_photos)
    end
    test "should not show not owned receipt" do
      get receipt_url(@receipt)

      assert_response :not_found
    end
    test "should not edit not owned receipt" do
      get edit_receipt_url(@receipt)

      assert_response :not_found
    end
    test "shoud not update not owned receipt" do
      patch receipt_url(@receipt), params: {
        receipt: {
          description: "Updated description",
          purchased_at: 1.day.ago,
          amount: 30000,
          currency: "usd"
        }
      }

      assert_response :not_found
    end
    test "should not destroy not owned receipt" do
      assert_no_difference("Receipt.count") do
        delete receipt_url(@receipt)
      end

      assert_response :not_found
    end
  end
end
