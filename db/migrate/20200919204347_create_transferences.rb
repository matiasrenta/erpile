class CreateTransferences < ActiveRecord::Migration
  def change
    create_table :transferences do |t|
      t.string :concept
      t.integer :from_user_id
      t.integer :to_user_id
      t.float :amount
      t.string :status

      t.timestamps null: false
    end
  end
end
