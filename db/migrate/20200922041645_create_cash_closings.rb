class CreateCashClosings < ActiveRecord::Migration
  def change
    create_table :cash_closings do |t|
      t.datetime :fecha_hora
      t.decimal :maxi_percent,precision: 10, scale: 2
      t.decimal :javi_percent,precision: 10, scale: 2
      t.decimal :marcos_percent,precision: 10, scale: 2
      t.decimal :mati_percent,precision: 10, scale: 2
      t.decimal :maxi_amount, precision: 10, scale: 2
      t.decimal :javi_amount, precision: 10, scale: 2
      t.decimal :marcos_amount, precision: 10, scale: 2
      t.decimal :mati_amount, precision: 10, scale: 2
      t.decimal :lapile_caja, precision: 10, scale: 2
      t.decimal :maxi_caja, precision: 10, scale: 2
      t.decimal :javi_caja, precision: 10, scale: 2
      t.decimal :marcos_caja, precision: 10, scale: 2
      t.decimal :mati_caja, precision: 10, scale: 2
      t.string :status

      t.timestamps null: false
    end
  end
end
