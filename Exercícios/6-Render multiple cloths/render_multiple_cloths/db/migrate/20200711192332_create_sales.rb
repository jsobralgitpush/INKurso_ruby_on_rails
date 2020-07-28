class CreateSales < ActiveRecord::Migration[5.1]
  def change
    create_table :sales do |t|
      t.integer :amount
      t.references :client, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
