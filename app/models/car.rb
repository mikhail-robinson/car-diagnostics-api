class Car < ApplicationRecord
  has_many :service_history_entries, dependent: :destroy
  validates :plate, :make, :model, :year, presence: true
end
