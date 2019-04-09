class ChangeInvitationsActivatedToAccepted < ActiveRecord::Migration[5.2]
  def change
    change_table :invitations do |t|
      t.rename :activated, :accepted
    end
  end
end
