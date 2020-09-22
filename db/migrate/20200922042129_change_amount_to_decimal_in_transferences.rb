class ChangeAmountToDecimalInTransferences < ActiveRecord::Migration
  def change
    change_column :transferences, :amount, :decimal, precision: 10, scale: 2
  end
end
