module Tmdb
  class Movie
    BASE_URL = "https://api.themoviedb.org/3/"

    def self.details(id)
      url = "#{BASE_URL}movie/#{id}"

      response = Faraday.get(url, {}, authorization_headers)

      return JSON.parse(response.body, { symbolize_names: true }) if response.success?

      {
        error_code: response.status,
        error_message: "Algo no ha ido como se esperaba..."
      }
    end

    def self.search(query, page = 1)
      url = "#{BASE_URL}search/movie"

      response = Faraday.get(url, { query:, page: }, authorization_headers)

      return JSON.parse(response.body, { symbolize_names: true }) if response.success?

      {
        error_code: response.status,
        error_message: "Algo no ha ido como se esperaba..."
      }
    end

    private

      def self.authorization_headers
        {
          "Authorization": "Bearer #{Rails.application.credentials.dig(:tmdb, :read_access_token)}"
        }
      end
  end
end
