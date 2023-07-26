class Customer < ApplicationRecord
  belongs_to :service_area

  validates :name, presence: true
  validates :primary_contact, presence: true, uniqueness: true
  validates :email, uniqueness: true

  enum status: { active: 'active', inactive: 'inactive' } 
end
