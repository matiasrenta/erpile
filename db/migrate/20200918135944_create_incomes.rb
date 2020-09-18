class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.integer :project_id
      t.string :concept
      t.decimal :amount, precision: 10, scale: 2
      t.date :fecha
      t.integer :user_id
      t.string :status

      t.timestamps null: false
    end
  end
end
