class AddHostIdColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :host_id, :string
    add_index  :events, :host_id
  end
end
