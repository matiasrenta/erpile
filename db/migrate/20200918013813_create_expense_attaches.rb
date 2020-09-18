class CreateExpenseAttaches < ActiveRecord::Migration
  def change
    create_table :expense_attaches do |t|
      t.integer :expense_id
      t.string :file_id
      t.string :file_filename
      t.integer :file_size
      t.string :file_content_type

      t.timestamps null: false
    end
  end
end
