class Invitation < ApplicationRecord
  
  belongs_to :event
  belongs_to :guest, class_name: 'User'
  
end