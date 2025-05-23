class AddTmdbIdToBookmarks < ActiveRecord::Migration[7.1]
  def change
    add_column :bookmarks, :tmdb_id, :integer
  end
end
