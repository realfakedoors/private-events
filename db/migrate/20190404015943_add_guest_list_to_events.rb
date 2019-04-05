class AddGuestListToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :guest_list, :string
  end
end
