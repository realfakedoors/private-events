class ChangeInvitationsGuestIdToGuestIds < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :guest_ids, :string
  end
end
