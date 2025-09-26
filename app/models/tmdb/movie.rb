module Tmdb
  class Movie
    BASE_URL = "https://api.themoviedb.org/3/"

    def self.details(id)
      fetch_data("movie/#{id}", {})
    end

    def self.search(query, page = 1)
      fetch_data("search/movie", { query:, page: })
    end

    private

      def self.authorization_headers
        {
          "Authorization": "Bearer #{Rails.application.credentials.dig(:tmdb, :read_access_token)}"
        }
      end

      def self.fetch_data(url, params)
        response = Faraday.get("#{BASE_URL}#{url}", params, authorization_headers)

        return JSON.parse(response.body, { symbolize_names: true }) if response.success?

        {
          error_code: response.status,
          error_message: "Algo no ha ido como se esperaba..."
        }
      end
  end
end
