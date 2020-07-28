class AddGeneroToCloths < ActiveRecord::Migration[5.1]
  def change
    add_column :cloths, :gender, :string
    add_column :cloths, :price, :integer
  end
end
