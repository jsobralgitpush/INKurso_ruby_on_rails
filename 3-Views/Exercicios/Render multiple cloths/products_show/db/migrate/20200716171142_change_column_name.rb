class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :cloths, :type, :style
  end
end
