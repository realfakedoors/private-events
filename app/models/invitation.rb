class Invitation < ApplicationRecord
  
  belongs_to :event, dependent: :destroy
  belongs_to :guest, class_name: 'User'
  
end