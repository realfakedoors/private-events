class AddActivatedBooleanToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :activated, :boolean, :default => false
  end
end
