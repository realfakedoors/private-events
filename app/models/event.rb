class Event < ApplicationRecord
  
  default_scope { order(datetime: :asc) }
  
  scope :past,   -> { where("datetime <= ?", DateTime.now) }
  scope :future, -> { where("datetime > ?", DateTime.now) }
  
  belongs_to :host, class_name: 'User'
  
  has_many :guests,      through: :invitations
  has_many :invitations, foreign_key: 'attended_event_id', dependent: :destroy
  
  validates :name,         presence: true, uniqueness: true
  validates :location,     presence: true
  validates :datetime,     presence: true
  
end