class RemoveGuestIdsStringFromInvitations < ActiveRecord::Migration[5.2]
  def change
    remove_column :invitations, :guest_ids, :string
  end
end
