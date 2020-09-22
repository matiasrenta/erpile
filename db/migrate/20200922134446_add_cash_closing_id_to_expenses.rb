class AddCashClosingIdToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :cash_closing_id, :integer
  end
end
