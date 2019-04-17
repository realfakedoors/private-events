class Invitation < ApplicationRecord
  
  belongs_to :event, foreign_key: 'attended_event_id', dependent: :destroy
  belongs_to :guest, class_name: 'User'
  
end