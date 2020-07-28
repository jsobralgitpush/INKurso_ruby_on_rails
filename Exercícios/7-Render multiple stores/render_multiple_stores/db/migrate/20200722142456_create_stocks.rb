class CreateStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.integer :stock
      t.references :cloth, foreign_key: true
      t.string :tamanho
      t.string :cor

      t.timestamps
    end
  end
end
