class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_customer

  def create
    @transaction = @customer.transactions.new(transaction_params)
    if @transaction.save
      render turbo_stream: turbo_stream.update(
        ActionView::RecordIdentifier.dom_id(@customer, @transaction.debit? ? :debit_transactions : :credit_transactions),
        partial: "customers/transactions/transaction_table",
        locals: { customer: @customer, transactions: @transaction.debit? ? @customer.debit_transactions : @customer.credit_transactions }
      )
    else
      # render turbo_stream to append error
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def transaction_params
    params.require(:transaction).permit(:transaction_type, :amount, :description)
  end
end
