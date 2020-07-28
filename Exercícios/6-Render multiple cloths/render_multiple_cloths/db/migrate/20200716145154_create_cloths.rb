class CreateCloths < ActiveRecord::Migration[5.1]
  def change
    create_table :cloths do |t|
      t.string :name
      t.string :style
      t.text :url

      t.timestamps
    end
  end
end
