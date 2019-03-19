class ChangeTimeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :time, :datetime
  end
end
