class Customer < ApplicationRecord
  belongs_to :service_area
  has_many :transactions
  has_many :debit_transactions, -> { where(transaction_type: "debit").order(:date) }, class_name: "Transaction"
  has_many :credit_transactions, -> { where(transaction_type: "credit").order(:date) }, class_name: "Transaction"

  validates :name, presence: true
  validates :primary_contact, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { minimum: 10, maximum: 10 }
  validates_uniqueness_of :email, allow_blank: true, case_sensitive: false

  enum status: { active: "active", inactive: "inactive" } 
end
