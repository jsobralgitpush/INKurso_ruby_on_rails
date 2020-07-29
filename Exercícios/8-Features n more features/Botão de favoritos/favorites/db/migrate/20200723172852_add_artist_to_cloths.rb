class AddArtistToCloths < ActiveRecord::Migration[5.1]
  def change
    add_column :cloths, :artist, :string
  end
end
