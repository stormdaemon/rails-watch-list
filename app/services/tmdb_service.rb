require 'net/http'
require 'json'

class TmdbService
  API_KEY = '5298647a051edd587f1692f716dc201f'
  BASE_URL = 'https://api.themoviedb.org/3'
  IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/w500'

  def self.search_movies(query)
    url = URI("#{BASE_URL}/search/movie")
    params = {
      api_key: API_KEY,
      query: query,
      language: 'fr-FR'
    }
    url.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(url)
    return [] unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    data['results'] || []
  rescue => e
    Rails.logger.error "TMDB API Error: #{e.message}"
    []
  end

  def self.get_movie_details(tmdb_id)
    url = URI("#{BASE_URL}/movie/#{tmdb_id}")
    params = {
      api_key: API_KEY,
      language: 'fr-FR'
    }
    url.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(url)
    return nil unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  rescue => e
    Rails.logger.error "TMDB API Error: #{e.message}"
    nil
  end

  def self.create_movie_from_tmdb(tmdb_id)
    movie_data = get_movie_details(tmdb_id)
    return nil unless movie_data

    Movie.find_or_create_by(tmdb_id: movie_data['id']) do |movie|
      movie.title = movie_data['title']
      movie.overview = movie_data['overview']
      movie.poster_url = movie_data['poster_path'] ? "#{IMAGE_BASE_URL}#{movie_data['poster_path']}" : nil
      movie.rating = movie_data['vote_average']
    end
  end
end
