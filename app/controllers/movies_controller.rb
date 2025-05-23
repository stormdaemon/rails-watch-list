class MoviesController < ApplicationController
  def search
    query = params[:query]
    if query.present?
      movies = TmdbService.search_movies(query)
      render json: movies
    else
      render json: []
    end
  end
end
