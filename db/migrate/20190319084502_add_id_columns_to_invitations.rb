class AddIdColumnsToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :attended_event_id, :string
    add_index  :invitations, :attended_event_id
    add_column :invitations, :guest_id,          :string
    add_index  :invitations, :guest_id
  end
end
