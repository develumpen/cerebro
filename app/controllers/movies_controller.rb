class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show ]

  def index
    @movies = params[:query] ? Tmdb::Movie.search(params[:query]) : []
  end

  def show
  end

  private
    def set_movie
      @movie = Movie.find_by_tmdb_id params[:id]
      return @movie if @movie

      tmdb_movie = Tmdb::Movie.details(params[:id])
      raise ActiveRecord::RecordNotFound if tmdb_movie[:error_code]

      @movie = Movie.create!(
        title: tmdb_movie[:title],
        tmdb_id: tmdb_movie[:id],
        imdb_id: tmdb_movie[:imdb_id],
        release_year: tmdb_movie[:release_date].split("-").first,
        poster_path: tmdb_movie[:poster_path],
        overview: tmdb_movie[:overview]
      )
    end
end
