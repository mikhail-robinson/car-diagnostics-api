class Car < ApplicationRecord
  has_many :service_entries, dependent: :destroy
end
