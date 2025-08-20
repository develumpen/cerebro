require "test_helper"

class LinkTest < ActiveSupport::TestCase
  setup do
    @link = links(:one)
  end

  test "is valid" do
    assert @link.valid?
  end

  test "is invalid without title" do
    @link.title = nil

    assert_not @link.valid?
    assert_not_empty @link.errors[:title]
  end

  test "is invalid without url" do
    @link.url = nil

    assert_not @link.valid?
    assert_not_empty @link.errors[:url]
  end

  test "is invalid with invalid url" do
    @link.url = "invalid"

    assert_not @link.valid?
    assert_not_empty @link.errors[:url]
  end
end
