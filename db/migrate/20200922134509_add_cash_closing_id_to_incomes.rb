class AddCashClosingIdToIncomes < ActiveRecord::Migration
  def change
    add_column :incomes, :cash_closing_id, :integer
  end
end
