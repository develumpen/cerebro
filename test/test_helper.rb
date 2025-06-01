ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

module AuthHelper
  def sign_in(user)
    user.sessions.create!(user_agent: nil, ip_address: nil).tap do |session|
      cookie_jar = ActionDispatch::TestRequest.create.cookie_jar
      cookie_jar.signed[:session_id] = { value: session.id, httponly: true, same_site: :lax }
      cookies[:session_id] = cookie_jar[:session_id]
    end
  end
end
