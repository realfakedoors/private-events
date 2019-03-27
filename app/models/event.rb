class Event < ApplicationRecord
  
  belongs_to :host, class_name: 'User'
  
  has_many :guests,      through: :invitations,            dependent: :destroy
  has_many :invitations, foreign_key: 'attended_event_id', dependent: :destroy
  
  validates :name,         presence: true, uniqueness: true
  validates :location,     presence: true
  validates :datetime,     presence: true
  
end