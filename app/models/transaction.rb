class Transaction < ApplicationRecord
  belongs_to :customer

  enum transaction_type: { credit: 'credit', debit: 'debit' } 
end
