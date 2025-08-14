require "application_system_test_case"

class SignInTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit sign_ins_url
  #
  #   assert_selector "h1", text: "SignIn"
  # end

  setup do
    @user = users(:one)
  end

  test "a user can sign in and sign out" do
    visit root_url

    assert_no_text "Desconectar"
    click_on "Conéctate"

    fill_in "email", with: @user.email
    fill_in "password", with: "password"
    click_on "Sign in"

    assert_no_text "Conéctate"
    assert_text "Desconectar"

    click_on "Desconectar"

    assert_text "Conéctate"
  end
end
