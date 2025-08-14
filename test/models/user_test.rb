require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "is valid" do
    assert @user.valid?
  end

  test "is not valid without username" do
    @user.username = nil

    assert_not @user.valid?
  end

  test "is not valid with unpermitted characters" do
    new_user = User.new(username: "cucamong@")

    assert_not new_user.valid?

    assert_includes new_user.errors[:username], "only allows letters, numbers and underscore"
  end

  test "is not valid if username is less than 3 characters" do
    new_user = User.new(username: "a", email: "a@email.com", password: "cucamonga")

    assert_not new_user.valid?
    assert_includes new_user.errors[:username], "is too short (minimum is 3 characters)"
  end

  test "is not valid if username is more than 20 characters" do
    new_user = User.new(username: "a" * 21, email: "a@email.com", password: "cucamonga")

    assert_not new_user.valid?
    assert_includes new_user.errors[:username], "is too long (maximum is 20 characters)"
  end

  test "is not valid if username or email already exists" do
    new_user = User.new(username: @user.username, email: @user.email, password: "cucamonga")

    assert_not new_user.valid?
    assert_includes new_user.errors[:username], "has already been taken"
    assert_includes new_user.errors[:email], "has already been taken"
  end

  test "is not valid without email" do
    @user.email = nil

    assert_not @user.valid?
  end
end
