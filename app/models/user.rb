class User < ApplicationRecord
  
  has_many :invitations,     foreign_key: 'guest_id', dependent: :destroy
  
  has_many :events,          foreign_key: 'host_id',  dependent: :destroy
  has_many :attended_events, through: :invitations,   dependent: :destroy
  
  validates :name, presence: true
  
end