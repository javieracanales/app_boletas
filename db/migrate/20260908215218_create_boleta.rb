class CreateBoleta < ActiveRecord::Migration[8.1]
  def change
    create_table :boleta do |t|
      t.string :rut_emisor
      t.string :razon_social
      t.string :folio
      t.date :fecha_emision
      t.integer :monto_total

      t.timestamps
    end
  end
end
