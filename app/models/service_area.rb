class ServiceArea < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
