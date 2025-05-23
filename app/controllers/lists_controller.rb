class ListsController < ApplicationController
  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @list_id = params[:id]
    @list = List.find(params[:id])
    # Je veux récuperer toutes les instances de bookmarks ayant pour list id
    # le list id sur lequel je show
    @list_bookmarks = Bookmark.where(list_id: @list_id)
    @movies_ids = @list_bookmarks.pluck(:movie_id)
    # je veux via ces instances récupérer tout les movie ID qui m'intéresse
    # et avec cette liste d'ID de movies récupérer tout les instance
    # de movies rattachés à ces id's
    @list_of_movies = Movie.where(id: @movies_ids)
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
