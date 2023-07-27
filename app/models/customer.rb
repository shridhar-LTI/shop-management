class Customer < ApplicationRecord
  belongs_to :service_area

  validates :name, presence: true
  validates :primary_contact, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { minimum: 10, maximum: 10 }
  validates_uniqueness_of :email, allow_blank: true, case_sensitive: false

  enum status: { active: 'active', inactive: 'inactive' } 
end
