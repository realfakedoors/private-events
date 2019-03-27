class ChangeForeignKeyColumnsToIntegers < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :host_id, :integer
    change_column :invitations, :guest_id, :integer
    change_column :invitations, :attended_event_id, :integer
  end
end
