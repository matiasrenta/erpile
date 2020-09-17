class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :project_id
      t.string :concept
      t.decimal :amount, precision: 10, scale: 2
      t.datetime :fecha
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
