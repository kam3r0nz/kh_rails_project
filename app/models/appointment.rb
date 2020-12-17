class Appointment < ApplicationRecord
  validates :date, presence: true
  belongs_to :animal
  belongs_to :veterinarian
  belongs_to :user
  has_many :services, through: :veterinarians
  belongs_to :service
end