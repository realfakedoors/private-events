class RemoveGuestListFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :guest_list, :text
  end
end
