class ChangeEventsGuestListToSerializedText < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :guest_list, :text
    change_column_default :events, :guest_list, [].to_yaml
  end
end