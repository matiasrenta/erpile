class AddFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :fecha_inicio_estimada, :date
    add_column :projects, :duracion_estimada, :integer
    add_column :projects, :porcentaje_avance, :decimal, precision: 3, scale: 2
  end
end
