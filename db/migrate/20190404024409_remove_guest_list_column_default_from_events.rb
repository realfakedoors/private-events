class RemoveGuestListColumnDefaultFromEvents < ActiveRecord::Migration[5.2]
  def change
    change_column_default :events, :guest_list, nil
  end
end
