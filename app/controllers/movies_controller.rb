class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show ]

  def index
    @movies = params[:query] ? Tmdb::Movie.search(params[:query]) : []
  end

  def show
  end

  private
    def set_movie
      @movie = Tmdb::Movie.details(params[:id])

      raise ActiveRecord::RecordNotFound if @movie[:error_code]
    end
end
