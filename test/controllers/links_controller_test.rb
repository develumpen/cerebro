require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @link = links(:one)
    @user = @link.user
  end

  test "should get index" do
    sign_in_as @user

    get links_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as @user

    get new_link_url
    assert_response :success
  end

  test "should create link" do
    sign_in_as @user

    assert_difference("Link.count") do
      post links_url, params: { link: { description: @link.description, title: @link.title, url: @link.url } }
    end

    assert_redirected_to links_url
  end

  test "should get edit" do
    sign_in_as @user

    get edit_link_url(@link)
    assert_response :success
  end

  test "should update link" do
    sign_in_as @user

    patch link_url(@link), params: { link: { description: @link.description, title: @link.title, url: @link.url } }
    assert_redirected_to links_url
  end

  test "should destroy link" do
    sign_in_as @user

    assert_difference("Link.count", -1) do
      delete link_url(@link)
    end

    assert_redirected_to links_url
  end
end
