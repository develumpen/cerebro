require "application_system_test_case"

class LinksTest < ApplicationSystemTestCase
  setup do
    @link = links(:one)
    @user = @link.user
  end

  test "visiting the index" do
    sign_in_as @user

    visit links_url
    assert_selector "h1", text: "Enlaces"
    assert_selector ".link", count: 1
  end

  test "should create link" do
    sign_in_as @user

    visit links_url
    click_on "Añadir enlace"

    fill_in "Description", with: "Description"
    fill_in "Title", with: "Title"
    fill_in "Url", with: "https://the-url.com"
    click_on "Create Link"

    # assert_text "Link was successfully created"
    assert_selector ".link > a", text: "Title"
  end

  test "should update Link" do
    sign_in_as @user

    visit links_url
    click_on "Editar", match: :first

    fill_in "Description", with: "updated description"
    fill_in "Title", with: "updated title"
    fill_in "Url", with: "https://updated-url.com"
    click_on "Update Link"

    # assert_text "Link was successfully updated"
    assert_selector ".link > a", text: "updated title"
  end

  test "should destroy Link" do
    sign_in_as @user

    visit links_url
    accept_alert do
      click_on "Eliminar", match: :first
    end

    assert_selector ".link", count: 1
  end
end
