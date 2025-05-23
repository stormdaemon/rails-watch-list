class BookmarksController < ApplicationController

  def create
    @list = List.find(params[:list_id])

    # Si c'est un film TMDB, on le crée d'abord
    if params[:bookmark][:tmdb_id].present?
      movie = TmdbService.create_movie_from_tmdb(params[:bookmark][:tmdb_id])
      if movie.nil?
        redirect_to list_path(@list), alert: 'Erreur lors de la récupération du film.'
        return
      end
      params[:bookmark][:movie_id] = movie.id
    end

    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list

    if @bookmark.save
      redirect_to list_path(@list), notice: 'Film ajouté avec succès à la liste.'
    else
      @list_of_movies = @list.movies
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list), notice: 'Film supprimé de la liste.'
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id, :tmdb_id)
  end
end
