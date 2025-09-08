module Tmdb
  class Movie
    def self.details(id)
      base_url = "https://api.themoviedb.org/3/movie"

      response = Faraday.get("#{base_url}/#{id}", {}, { "Authorization": "Bearer #{Rails.application.credentials.dig(:tmdb, :read_access_token)}" })

      return JSON.parse(response.body, { symbolize_names: true }) if response.success?

      Rails.logger.debug("-" * 10)
      Rails.logger.debug(response)
      Rails.logger.debug("-" * 10)
      {
        error_code: response.status,
        error_message: "Algo no ha ido como se esperaba..."
      }
    end

    def self.search(query, page = 1)
      response = Faraday.get("https://api.themoviedb.org/3/search/movie", { query:, page: }, { "Authorization": "Bearer #{Rails.application.credentials.dig(:tmdb, :read_access_token)}" })

      return JSON.parse(response.body, { symbolize_names: true }) if response.success?

      Rails.logger.debug("-" * 10)
      Rails.logger.debug(response)
      Rails.logger.debug("-" * 10)
      {
        error_code: response.status,
        error_message: "Algo no ha ido como se esperaba..."
      }
    end
  end
end
