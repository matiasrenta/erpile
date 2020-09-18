class CreateProjectAttaches < ActiveRecord::Migration
  def change
    create_table :project_attaches do |t|
      t.integer :project_id
      t.string :file_id
      t.string :file_filename
      t.integer :file_size
      t.string :file_content_type

      t.timestamps null: false
    end
  end
end
