require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:one)
    @user = users(:one)
  end

  test "should get index" do
    sign_in_as @user

    get movies_url
    assert_response :success
  end

  test "should get movie" do
    sign_in_as @user

    get movie_url(@movie.tmdb_id)
    assert_response :success
  end
end
